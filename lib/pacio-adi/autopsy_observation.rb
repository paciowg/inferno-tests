module PacioAdi
    class AutopsyObservation < Inferno::TestGroup
      title 'Autopsy Observation (PACIO Advance Directives) Tests'
        
      description 'Verify support for the server capabilities required by the Autopsy Observation profile.'
      id :pacio_adi_autopsy_observation
  
      test do
        title 'Server returns correct Autopsy Observation resource from the Autopsy Observation read interaction'
        description %(
          This test will verify that Autopsy Observation resources can be read from the server.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-AutopsyObservation
  
      input :autopsy_observation_id
      makes_request :autopsy_observation
  
      run do
        fhir_read(:observation, autopsy_observation_id, name: :autopsy_observation)
  
        assert_response_status(200)
          assert_resource_type(:observation)
          assert resource.id == autopsy_observation_id,
                 "Requested resource with id #{autopsy_observation_id}, received resource with id #{resource.id}"
        end
      end
  
      test do
        title 'Server returns Autopsy Observation resoure that matches the Autopsy Observation (PACIO Advance Directives) profile'
        description %(
          This test will validate that the Autopsy Observation resource returned from the server matches the Autopsy Observation (PACIO Advance Directives) profile.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-AutopsyObservation
        uses_request :autopsy_observation
  
        run do
          assert_valid_resource(profile_url: 'http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-AutopsyObservation')
        end
      end
  
    end
  end