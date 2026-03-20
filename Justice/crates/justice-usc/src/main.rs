use clap::{Parser, Subcommand};
use justice_usc::{CitationParser, StatuteIndex, UscParser, UscDownloader};
use std::path::PathBuf;

#[derive(Parser)]
#[command(name = "justice-usc")]
#[command(about = "U.S. Code parser and citation lookup tool", long_about = None)]
struct Cli {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand)]
enum Commands {
    /// Look up a statute by citation (e.g., "18 U.S.C. 1343")
    Cite {
        /// Citation to look up
        citation: String,
    },
    
    /// Parse USC XML file (placeholder)
    Parse {
        /// Input XML file path
        #[arg(short, long)]
        input: String,
        
        /// Output TOML directory
        #[arg(short, long)]
        output: String,
    },
    
    /// List available statutes in the index
    List,
    
    /// Download USC titles from GovInfo
    Download {
        /// Specific title to download (1-54), or "all" for all titles
        #[arg(short, long)]
        title: Option<String>,
        
        /// Output directory for downloaded XML files
        #[arg(short, long, default_value = "usc/raw")]
        output: PathBuf,
    },
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let cli = Cli::parse();
    
    match cli.command {
        Commands::Cite { citation } => {
            println!("Looking up citation: {}\n", citation);
            
            let parsed = CitationParser::parse(&citation)?;
            println!("Parsed citation:");
            println!("  Title: {}", parsed.title);
            println!("  Section: {}", parsed.section);
            if let Some(ref sub) = parsed.subsection {
                println!("  Subsection: {}", sub);
            }
            println!("  Canonical: {}\n", parsed.canonical);
            
            let index = StatuteIndex::new();
            match index.lookup(&parsed) {
                Ok(toml_content) => {
                    println!("Statute found:\n");
                    println!("{}", toml_content);
                }
                Err(e) => {
                    eprintln!("Error: {}", e);
                    eprintln!("\nAvailable statutes:");
                    eprintln!("  - 18 U.S.C. § 1341 (Mail fraud)");
                    eprintln!("  - 18 U.S.C. § 1343 (Wire fraud)");
                    std::process::exit(1);
                }
            }
        }
        
        Commands::Parse { input, output } => {
            println!("Parsing USC XML from: {}", input);
            println!("Output directory: {}", output);
            println!("\nNote: Full XML parsing not yet implemented.");
            println!("This will parse USLM XML from uscode.house.gov");
            
            let sample = UscParser::parse_xml("")?;
            println!("\nSample parsed title:");
            println!("  Title {}: {}", sample.number, sample.heading);
            println!("  Chapters: {}", sample.chapters.len());
        }
        
        Commands::List => {
            println!("Available statutes in index:\n");
            println!("Title 18 - Crimes and Criminal Procedure");
            println!("  § 1341 - Frauds and swindles (Mail fraud)");
            println!("  § 1343 - Fraud by wire, radio, or television (Wire fraud)");
            println!("\nTo look up a statute, use:");
            println!("  justice-usc cite \"18 U.S.C. 1343\"");
        }
        
        Commands::Download { title, output } => {
            let runtime = tokio::runtime::Runtime::new()?;
            runtime.block_on(async {
                let downloader = UscDownloader::new();
                std::fs::create_dir_all(&output)?;
                
                match title.as_deref() {
                    Some("all") | None => {
                        println!("Downloading all USC titles to {:?}...\n", output);
                        downloader.download_all_titles(&output).await?;
                        println!("\n✓ Download complete!");
                    }
                    Some(title_str) => {
                        let title_num: u32 = title_str.parse()
                            .map_err(|_| format!("Invalid title number: {}", title_str))?;
                        
                        if title_num < 1 || title_num > 54 {
                            return Err(format!("Title must be between 1 and 54, got {}", title_num).into());
                        }
                        
                        println!("Downloading Title {} to {:?}...\n", title_num, output);
                        downloader.download_title(title_num, &output).await?;
                        println!("\n✓ Download complete!");
                    }
                }
                
                Ok::<(), Box<dyn std::error::Error>>(())
            })?;
        }
    }
    
    Ok(())
}
