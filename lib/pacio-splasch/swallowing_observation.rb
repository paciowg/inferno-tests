module PacioSplasch
    class SwallowingObservation < Inferno::TestGroup
      title 'Swallowing Observation (PACIO SPLASCH) Tests'
        
      description 'Verify support for the server capabilities required by the Swallowing Observation profile.'
      id :pacio_splasch_swallowing_observation
  
      input :swallowing_observation_id
  
      test do
        title 'Server returns correct Swallowing Observation resource from the read interaction'
        description %(
          This test will verify that Swallowing Observation resources can be read from the server.
        )
  
      makes_request :observation
  
      run do
        fhir_read(:observation, swallowing_observation_id, name: :observation)
  
        assert_response_status(200)
          assert_resource_type(:observation)
          assert resource.id == swallowing_observation_id,
                 "Requested resource with id #{swallowing_observation_id}, received resource with id #{resource.id}"
        end
      end
  
      test do
        title 'Server returns Swallowing Observation resoure that matches the Swallowing Observation (PACIO SPLASCH) profile'
        description %(
          This test will validate that the Swallowing Observation resource returned from the server matches the Swallowing Observation (PACIO SPLASCH) profile.
        )
        uses_request :observation
  
        run do
          assert_valid_resource(profile_url: 'http://hl7.org/fhir/us/pacio-splasch/StructureDefinition/splasch-SwallowingObservation')
        end
      end
  
  
      test do
        title 'Server supports searching Swallowing Observation (PACIO SPLASCH) profile by ID'
        description %(
          This test will validate that the FHIR server supports searching Swallowing Observation by ID (PACIO SPLASCH) profile.
        )
  
        uses_request :observation
  
        run do
          fhir_search :observation, params: { _id: resource.id }
  
          assert_response_status(200)
          assert_resource_type('Bundle')
        end
      end
  
    end
  end