module PacioAdi
    class HealthcareAgent < Inferno::TestGroup
      title 'Healthcare Agent (PACIO Advance Directives) Tests'
        
      description 'Verify support for the server capabilities required by the Healthcare Agent profile.'
      id :pacio_adi_healthcare_agent
  
      test do
        title 'Server returns correct Healthcare Agent resource from the Healthcare Agent read interaction'
        description %(
          This test will verify that Healthcare Agent resources can be read from the server.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-HealthcareAgent
  
      input :healthcare_agent_id
      makes_request :healthcare_agent
  
      run do
        fhir_read(:relatedperson, healthcare_agent_id, name: :healthcare_agent)
  
        assert_response_status(200)
          assert_resource_type(:relatedperson)
          assert resource.id == healthcare_agent_id,
                 "Requested resource with id #{healthcare_agent_id}, received resource with id #{resource.id}"
        end
      end
  
      test do
        title 'Server returns Healthcare Agent resoure that matches the Healthcare Agent (PACIO Advance Directives) profile'
        description %(
          This test will validate that the Healthcare Agent resource returned from the server matches the Healthcare Agent (PACIO Advance Directives) profile.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-HealthcareAgent
        uses_request :healthcare_agent
  
        run do
          assert_valid_resource(profile_url: 'http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-HealthcareAgent')
        end
      end
  
    end
  end