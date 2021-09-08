module PacioAdi
    class PmolstObservation < Inferno::TestGroup
      title 'PMOLST Observation (PACIO Advance Directives) Tests'
        
      description 'Verify support for the server capabilities required by the PMOLST Observation profile.'
      id :pacio_adi_pmolst_observation
  
      test do
        title 'Server returns correct PMOLST Observation resource from the PMOLST Observation read interaction'
        description %(
          This test will verify that PMOLST Observation resources can be read from the server.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-PMOLSTObservation
  
      input :pmolst_observation_id
      makes_request :pmolst_observation
  
      run do
        fhir_read(:observation, pmolst_observation_id, name: :pmolst_observation)
  
        assert_response_status(200)
          assert_resource_type(:observation)
          assert resource.id == pmolst_observation_id,
                 "Requested resource with id #{pmolst_observation_id}, received resource with id #{resource.id}"
        end
      end
  
      test do
        title 'Server returns PMOLST Observation resoure that matches the PMOLST Observation (PACIO Advance Directives) profile'
        description %(
          This test will validate that the PMOLST Observation resource returned from the server matches the PMOLST Observation (PACIO Advance Directives) profile.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-PMOLSTObservation
        uses_request :pmolst_observation
  
        run do
          assert_valid_resource(profile_url: 'http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-PMOLSTObservation')
        end
      end
  
    end
  end