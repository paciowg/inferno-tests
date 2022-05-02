module PacioFp
    class FpNarrativeHistoryOfStatus < Inferno::TestGroup
      title 'PACIO Functional Performance Narrative History of Status Tests'
        
      description 'Verify support for the server capabilities required by the Functional Performance Narrative History of Status profile.'
      id :pacio_fp_narrative_history_of_status
  
      input :fp_narrative_history_of_status_id
  
      test do
        title 'Server returns correct Functional Performance Narrative History of Status resource from the read interaction'
        description %(
          This test will verify that Functional Performance Narrative History of Status resources can be read from the server.
        )
  
      makes_request :narrative_history_of_status
  
      run do
        fhir_read(:narrative_history_of_status, fp_narrative_history_of_status_id, name: :narrative_history_of_status)
  
        assert_response_status(200)
          assert_resource_type(:narrative_history_of_status)
          assert resource.id == fp_narrative_history_of_status_id,
                 "Requested resource with id #{fp_narrative_history_of_status_id}, received resource with id #{resource.id}"
        end
      end
  
      test do
        title 'Server returns Functional Performance Narrative History of Status resoure that matches the PACIO Functional Performance Narrative History of Status profile'
        description %(
          This test will validate that the Functional Performance Narrative History of Status resource returned from the server matches the PACIO Functional Performance Narrative History of Status profile.
        )
        uses_request :narrative_history_of_status
        
        run do
          assert_valid_resource(profile_url: 'http://hl7.org/fhir/us/pacio-fp/StructureDefinition/fp-narrative-history-of-status')
        end
      end
  
  
      test do
        title 'Server supports searching PACIO Functional Performance Narrative History of Status profile by ID'
        description %(
          This test will validate that the FHIR server supports searching PACIO Functional Performance Narrative History of Status profile by ID.
        )
  
        uses_request :narrative_history_of_status
  
        run do
          fhir_search :narrative_history_of_status, params: { _id: resource.id }
  
          assert_response_status(200)
          assert_resource_type('Bundle')
        end
      end
  
    end
  end