module PacioFp
    class FpObservation < Inferno::TestGroup
      title 'PACIO Functional Performance Observation Tests'
        
      description 'Verify support for the server capabilities required by the Functional Performance Observation profile.'
      id :pacio_fp_observation
  
      input :fp_observation_id
  
      test do
        title 'Server returns correct Functional Performance Observation resource from the read interaction'
        description %(
          This test will verify that Functional Performance Observation resources can be read from the server.
        )
  
      makes_request :observation
  
      run do
        fhir_read(:observation, fp_observation_id, name: :observation)
  
        assert_response_status(200)
          assert_resource_type(:observation)
          assert resource.id == fp_observation_id,
                 "Requested resource with id #{fp_observation_id}, received resource with id #{resource.id}"
        end
      end
  
      test do
        title 'Server returns Functional Performance Observation resoure that matches the PACIO Functional Performance Observation profile'
        description %(
          This test will validate that the Functional Performance Observation resource returned from the server matches the PACIO Functional Performance Observation profile.
        )
        uses_request :observation
        
        run do
          assert_valid_resource(profile_url: 'http://hl7.org/fhir/us/pacio-fp/StructureDefinition/fp-observation')
        end
      end
  
  
      test do
        title 'Server supports searching PACIO Functional Performance Observation profile by ID'
        description %(
          This test will validate that the FHIR server supports searching PACIO Functional Performance Observation profile by ID.
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