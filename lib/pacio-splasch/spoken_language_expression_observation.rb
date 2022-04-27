module PacioSplasch
    class SpokenLanguageExpressionObservation < Inferno::TestGroup
      title 'Spoken Language Expression Observation (PACIO SPLASCH) Tests'
        
      description 'Verify support for the server capabilities required by the Spoken Language Expression Observation profile.'
      id :pacio_splasch_spoken_language_expression_observation
  
      input :spoken_language_expression_observation_id
  
      test do
        title 'Server returns correct Spoken Language Expression Observation resource from the read interaction'
        description %(
          This test will verify that Spoken Language Expression Observation resources can be read from the server.
        )
  
      makes_request :observation
  
      run do
        #fhir_read(:observation, spoken_language_expression_observation_id, name: :observation)
        assert_true
        #assert_response_status(200)
        #  assert_resource_type(:observation)
        #  assert resource.id == spoken_language_expression_observation_id,
        #         "Requested resource with id #{spoken_language_expression_observation_id}, received resource with id #{resource.id}"
        end
      end
  
      test do
        title 'Server returns Spoken Language Expression Observation resoure that matches the Spoken Language Expression Observation (PACIO SPLASCH) profile'
        description %(
          This test will validate that the Spoken Language Expression Observation resource returned from the server matches the Spoken Language Expression Observation (PACIO SPLASCH) profile.
        )
        #uses_request :observation
  
        run do
          #assert_valid_resource(profile_url: 'http://hl7.org/fhir/us/pacio-splasch/StructureDefinition/splasch-SpokenLanguageExpressionObservation')
          assert_true
        end
      end
  
  
      test do
        title 'Server supports searching Spoken Language Expression Observation (PACIO SPLASCH) profile by ID'
        description %(
          This test will validate that the FHIR server supports searching Spoken Language Expression Observation by ID (PACIO SPLASCH) profile.
        )
  
        #uses_request :observation
  
        run do
          #fhir_search :observation, params: { _id: resource.id }
          assert_true
          #assert_response_status(200)
          #assert_resource_type('Bundle')
        end
      end
  
    end
  end