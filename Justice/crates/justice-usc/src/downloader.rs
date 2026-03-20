use crate::Result;
use std::path::Path;

pub struct UscDownloader {
    base_url: String,
}

impl UscDownloader {
    pub fn new() -> Self {
        Self {
            base_url: "https://www.govinfo.gov/content/pkg".to_string(),
        }
    }
    
    /// Download a specific USC title from GovInfo
    pub async fn download_title(&self, title: u32, output_dir: &Path) -> Result<()> {
        let url = format!("{}/USCODE-{}-title{}/xml/USCODE-{}-title{}.xml", 
            self.base_url, 
            "2023",  // Latest available year
            title,
            "2023",
            title
        );
        
        println!("Downloading Title {} from GovInfo...", title);
        println!("URL: {}", url);
        
        let response = reqwest::get(&url).await
            .map_err(|e| crate::UscError::IoError(std::io::Error::new(std::io::ErrorKind::Other, e)))?;
        
        if !response.status().is_success() {
            return Err(crate::UscError::IoError(
                std::io::Error::new(
                    std::io::ErrorKind::NotFound,
                    format!("Failed to download title {}: HTTP {}", title, response.status())
                )
            ));
        }
        
        let content = response.bytes().await
            .map_err(|e| crate::UscError::IoError(std::io::Error::new(std::io::ErrorKind::Other, e)))?;
        
        let output_path = output_dir.join(format!("title{:02}.xml", title));
        std::fs::write(&output_path, content)?;
        
        println!("Downloaded Title {} to {:?}", title, output_path);
        Ok(())
    }
    
    /// Download all 54 USC titles
    pub async fn download_all_titles(&self, output_dir: &Path) -> Result<()> {
        std::fs::create_dir_all(output_dir)?;
        
        // USC has 54 titles (some are reserved/repealed)
        let active_titles = vec![
            1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
            11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
            21, 22, 23, 24, 25, 26, 28, 29, 30,
            31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
            41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
            51, 52, 54,
        ];
        
        for title in active_titles {
            match self.download_title(title, output_dir).await {
                Ok(_) => println!("✓ Title {} downloaded", title),
                Err(e) => eprintln!("✗ Title {} failed: {}", title, e),
            }
            
            // Rate limiting
            tokio::time::sleep(tokio::time::Duration::from_millis(500)).await;
        }
        
        Ok(())
    }
}

impl Default for UscDownloader {
    fn default() -> Self {
        Self::new()
    }
}
