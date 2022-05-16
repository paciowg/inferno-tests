module PacioSplasch
    class HearingObservation < Inferno::TestGroup
      title 'Hearing Observation (PACIO SPLASCH) Tests'
        
      description 'Verify support for the server capabilities required by the Hearing Observation profile.'
      id :pacio_splasch_hearing_observation
  
      input :hearing_observation_id
  
      test do
        title 'Server returns correct Hearing Observation resource from the read interaction'
        description %(
          This test will verify that Hearing Observation resources can be read from the server.
        )
  
      makes_request :observation
  
      run do
        fhir_read(:observation, hearing_observation_id, name: :observation)
  
        assert_response_status(200)
          assert_resource_type(:observation)
          assert resource.id == hearing_observation_id,
                 "Requested resource with id #{hearing_observation_id}, received resource with id #{resource.id}"
        end
      end
  
      test do
        title 'Server returns Hearing Observation resoure that matches the Hearing Observation (PACIO SPLASCH) profile'
        description %(
          This test will validate that the Hearing Observation resource returned from the server matches the Hearing Observation (PACIO SPLASCH) profile.
        )
        uses_request :observation
  
        run do
          assert_valid_resource(profile_url: 'http://hl7.org/fhir/us/pacio-splasch/StructureDefinition/splasch-HearingObservation')
        end
      end
  
  
      test do
        title 'Server supports searching Hearing Observation (PACIO SPLASCH) profile by ID'
        description %(
          This test will validate that the FHIR server supports searching Hearing Observation by ID (PACIO SPLASCH) profile.
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