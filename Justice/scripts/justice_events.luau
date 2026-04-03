-- Justice System Event Handlers
-- Handles inmate classification, interventions, and compliance

-- Configuration
local MIN_CONFIDENCE_FOR_INTERVENTION = 0.7
local LOW_CONFIDENCE_THRESHOLD = 0.5

-- Track active interventions
local activeInterventions = {}

-- ============================================================
-- EVENT HANDLERS
-- ============================================================

-- Handle inmate classification from Karbuche
EventBus:Connect("inmate_classified", function(args)
    local entityId = args[1]
    local inmateId = args[2]
    local classification = args[3]
    local confidence = args[4]
    
    print(string.format(
        "[Justice] Inmate %s classified as '%s' (confidence: %.2f)",
        inmateId, classification, confidence
    ))
    
    -- Low confidence = needs closer monitoring
    if confidence < LOW_CONFIDENCE_THRESHOLD then
        EventBus:Fire("monitoring_increased", {
            inmate_id = inmateId,
            reason = "low_classification_confidence",
            action = "increase_surveillance"
        })
    end
    
    -- High-risk classification triggers intervention
    if classification == "violent_behavior" and confidence >= MIN_CONFIDENCE_FOR_INTERVENTION then
        EventBus:Fire("intervention_required", {
            inmate_id = inmateId,
            classification = classification,
            confidence = confidence,
            recommended_action = "immediate_counseling"
        })
    elseif classification == "self_harm_risk" and confidence >= MIN_CONFIDENCE_FOR_INTERVENTION then
        EventBus:Fire("medical_alert", {
            inmate_id = inmateId,
            severity = "high",
            reason = "self_harm_detected"
        })
    elseif classification == "cooperative" and confidence >= 0.8 then
        -- Positive behavior = rehabilitation progress
        EventBus:Fire("rehabilitation_milestone", {
            inmate_id = inmateId,
            milestone = "positive_behavior_30_days",
            reward = "program_privileges"
        })
    end
end)

-- Handle violence detection (from 3D CNN/depth cameras)
EventBus:Connect("violence_detected", function(args)
    local location = args[1]
    local confidence = args[2]
    local involvedInmates = args[3]
    
    print(string.format(
        "[Justice] VIOLENCE DETECTED at %s (confidence: %.2f)",
        location, confidence
    ))
    
    -- Immediate response
    EventBus:Fire("immediate_response", {
        type = "violence",
        location = location,
        priority = "critical",
        dispatch_security = true,
        dispatch_medical = confidence > 0.9
    })
    
    -- Log for compliance
    EventBus:Fire("incident_logged", {
        incident_type = "violence",
        location = location,
        involved_parties = involvedInmates,
        timestamp = os.time(),
        usc_violation_check = "28 USC 1983"
    })
end)

-- Handle anomaly detection (crowd dynamics)
EventBus:Connect("anomaly_alert", function(args)
    local anomalyType = args[1]
    local location = args[2]
    local confidence = args[3]
    local involvedInmates = args[4]
    
    print(string.format(
        "[Justice] Anomaly: %s at %s (confidence: %.2f)",
        anomalyType, location, confidence
    ))
    
    -- Different responses based on anomaly type
    if anomalyType == "unusual_clustering" then
        EventBus:Fire("monitoring_increased", {
            location = location,
            reason = "crowd_anomaly",
            action = "deploy_additional_staff"
        })
    elseif anomalyType == "conflict_escalation" then
        EventBus:Fire("intervention_required", {
            location = location,
            type = "de_escalation",
            priority = "high",
            involved_inmates = involvedInmates
        })
    elseif anomalyType == "medical_emergency" then
        EventBus:Fire("medical_alert", {
            location = location,
            severity = "critical",
            reason = anomalyType
        })
    end
end)

-- Handle intervention assignment
EventBus:Connect("intervention_assigned", function(args)
    local interventionId = args[1]
    local inmateId = args[2]
    local interventionType = args[3]
    local assignedStaff = args[4]
    
    print(string.format(
        "[Justice] Intervention %s assigned to %s (staff: %s)",
        interventionId, inmateId, assignedStaff
    ))
    
    -- Track active intervention
    activeInterventions[interventionId] = {
        inmate_id = inmateId,
        type = interventionType,
        staff = assignedStaff,
        start_time = os.time(),
        status = "assigned"
    }
    
    -- Staff notification
    EventBus:Fire("staff_notification", {
        staff_id = assignedStaff,
        notification_type = "intervention_assigned",
        intervention_id = interventionId,
        location = args[5] or "unknown"
    })
end)

-- Handle intervention completion
EventBus:Connect("intervention_completed", function(args)
    local interventionId = args[1]
    local outcome = args[2]
    
    local intervention = activeInterventions[interventionId]
    if intervention then
        intervention.status = "completed"
        intervention.outcome = outcome
        intervention.end_time = os.time()
        
        print(string.format(
            "[Justice] Intervention %s completed with outcome: %s",
            interventionId, outcome
        ))
        
        -- Update inmate record
        EventBus:Fire("inmate_record_updated", {
            inmate_id = intervention.inmate_id,
            update_type = "intervention_completed",
            intervention_id = interventionId,
            outcome = outcome
        })
        
        -- Compliance audit
        EventBus:Fire("audit_record_created", {
            record_type = "intervention",
            intervention_id = interventionId,
            outcome = outcome,
            duration_seconds = intervention.end_time - intervention.start_time,
            immutable_hash = "computed_hash_here"
        })
    end
end)

-- Handle compliance violations
EventBus:Connect("compliance_violation", function(args)
    local uscSection = args[1]
    local violationType = args[2]
    local details = args[3]
    
    print(string.format(
        "[Justice] COMPLIANCE VIOLATION: %s - %s",
        uscSection, violationType
    ))
    
    -- Immediate escalation
    EventBus:Fire("administrator_alert", {
        alert_type = "compliance_violation",
        severity = "critical",
        usc_section = uscSection,
        violation_type = violationType,
        details = details,
        requires_immediate_action = true
    })
    
    -- Immutable audit record
    EventBus:Fire("audit_record_created", {
        record_type = "compliance_violation",
        usc_section = uscSection,
        violation_type = violationType,
        timestamp = os.time(),
        immutable_hash = "computed_hash_here"
    })
end)

-- Handle rights violations (Title 28 § 1983)
EventBus:Connect("rights_violation", function(args)
    local inmateId = args[1]
    local rightViolated = args[2]
    local violationDetails = args[3]
    
    print(string.format(
        "[Justice] RIGHTS VIOLATION: Inmate %s - %s",
        inmateId, rightViolated
    ))
    
    -- Immediate legal escalation
    EventBus:Fire("legal_escalation", {
        inmate_id = inmateId,
        right_violated = rightViolated,
        details = violationDetails,
        usc_reference = "28 USC 1983",
        requires_legal_review = true
    })
end)

-- Handle program assignments
EventBus:Connect("program_assigned", function(args)
    local inmateId = args[1]
    local programName = args[2]
    local reason = args[3]
    
    print(string.format(
        "[Justice] Program '%s' assigned to %s (reason: %s)",
        programName, inmateId, reason
    ))
    
    EventBus:Fire("rehabilitation_plan_updated", {
        inmate_id = inmateId,
        new_program = programName,
        assignment_reason = reason,
        expected_completion = os.time() + (30 * 24 * 60 * 60) -- 30 days
    })
end)

-- Handle rehabilitation milestones
EventBus:Connect("rehabilitation_milestone", function(args)
    local inmateId = args[1]
    local milestone = args[2]
    
    print(string.format(
        "[Justice] Milestone achieved: %s by %s",
        milestone, inmateId
    ))
    
    -- Positive reinforcement
    EventBus:Fire("positive_reinforcement", {
        inmate_id = inmateId,
        milestone = milestone,
        privileges_granted = {
            "recreational_time",
            "visitation_priority"
        }
    })
end)

-- Handle predictive alerts
EventBus:Connect("predictive_alert", function(args)
    local incidentType = args[1]
    local probability = args[2]
    local location = args[3]
    local etaMinutes = args[4]
    
    print(string.format(
        "[Justice] PREDICTION: %s at %s in %d min (%.0f%% probability)",
        incidentType, location, etaMinutes, probability * 100
    ))
    
    -- Preemptive response if high probability
    if probability > 0.8 then
        EventBus:Fire("preemptive_intervention", {
            predicted_incident = incidentType,
            location = location,
            eta_minutes = etaMinutes,
            action = "deploy_preventive_staff"
        })
    end
end)

-- Handle audit record creation
EventBus:Connect("audit_record_created", function(args)
    local recordType = args[1]
    local recordHash = args[2]
    
    print(string.format(
        "[Justice] Audit record created: %s (hash: %s)",
        recordType, recordHash
    ))
    
    -- Ensure immutable storage
    EventBus:Fire("immutable_backup", {
        record_type = recordType,
        hash = recordHash,
        timestamp = os.time(),
        retention_years = 7
    })
end)

-- ============================================================
-- UTILITY FUNCTIONS
-- ============================================================

-- Get active interventions
function GetActiveInterventions()
    local count = 0
    for _, _ in pairs(activeInterventions) do
        count = count + 1
    end
    return count
end

-- Clean up old completed interventions
function CleanupOldInterventions(maxAgeSeconds)
    local now = os.time()
    for id, intervention in pairs(activeInterventions) do
        if intervention.status == "completed" then
            if intervention.end_time and (now - intervention.end_time) > maxAgeSeconds then
                activeInterventions[id] = nil
            end
        end
    end
end

-- Periodic cleanup
EventBus:Connect("system_tick", function(args)
    CleanupOldInterventions(24 * 60 * 60) -- Clean up after 24 hours
end)

print("[Justice] Luau event handlers initialized")
print("[Justice] Listening for: inmate_classified, violence_detected, anomaly_alert,")
print("          intervention_assigned, intervention_completed, compliance_violation,")
print("          rights_violation, program_assigned, rehabilitation_milestone,")
print("          predictive_alert, audit_record_created")
