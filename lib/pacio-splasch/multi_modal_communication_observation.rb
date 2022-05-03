module PacioSplasch
    class MultiModalCommunicationObservation < Inferno::TestGroup
      title 'Multi-Modal Communication Observation (PACIO SPLASCH) Tests'
        
      description 'Verify support for the server capabilities required by the Multi-Modal Communication Observation profile.'
      id :pacio_splasch_multi_modal_communication_observation
  
      input :multi_modal_communication_observation_id
  
      test do
        title 'Server returns correct Multi-Modal Communication Observation resource from the read interaction'
        description %(
          This test will verify that Multi-Modal Communication Observation resources can be read from the server.
        )
  
      makes_request :observation
  
      run do
        fhir_read(:observation, multi_modal_communication_observation_id, name: :observation)
  
        assert_response_status(200)
          assert_resource_type(:observation)
          assert resource.id == multi_modal_communication_observation_id,
                 "Requested resource with id #{multi_modal_communication_observation_id}, received resource with id #{resource.id}"
        end
      end
  
      test do
        title 'Server returns Multi-Modal Communication Observation resoure that matches the Multi-Modal Communication Observation (PACIO SPLASCH) profile'
        description %(
          This test will validate that the Multi-Modal Communication Observation resource returned from the server matches the Multi-Modal Communication Observation (PACIO SPLASCH) profile.
        )
        uses_request :observation
  
        run do
          assert_valid_resource(profile_url: 'http://hl7.org/fhir/us/pacio-splasch/StructureDefinition/splasch-MultiModalCommunicationObservation')
        end
      end
  
  
      test do
        title 'Server supports searching Multi-Modal Communication Observation (PACIO SPLASCH) profile by ID'
        description %(
          This test will validate that the FHIR server supports searching Multi-Modal Communication Observation by ID (PACIO SPLASCH) profile.
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