module PacioAdi
    class HealthcareAgentConsent < Inferno::TestGroup
      title 'Healthcare Agent Consent (PACIO Advance Directives) Tests'
        
      description 'Verify support for the server capabilities required by the Healthcare Agent Consent profile.'
      id :pacio_adi_healthcare_agent_consent
  
      test do
        title 'Server returns correct Healthcare Agent Consent resource from the Healthcare Agent Consent read interaction'
        description %(
          This test will verify that Healthcare Agent Consent resources can be read from the server.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-HealthcareAgentConsent
  
      input :healthcare_agent_consent_id
      makes_request :healthcare_agent_consent
  
      run do
        fhir_read(:consent, healthcare_agent_consent_id, name: :healthcare_agent_consent)
  
        assert_response_status(200)
          assert_resource_type(:consent)
          assert resource.id == healthcare_agent_consent_id,
                 "Requested resource with id #{healthcare_agent_consent_id}, received resource with id #{resource.id}"
        end
      end
  
      test do
        title 'Server returns Healthcare Agent Consent resoure that matches the Healthcare Agent Consent (PACIO Advance Directives) profile'
        description %(
          This test will validate that the Healthcare Agent Consent resource returned from the server matches the Healthcare Agent Consent (PACIO Advance Directives) profile.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-HealthcareAgentConsent
        uses_request :healthcare_agent_consent
  
        run do
          assert_valid_resource(profile_url: 'http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-HealthcareAgentConsent')
        end
      end
  
    end
  end