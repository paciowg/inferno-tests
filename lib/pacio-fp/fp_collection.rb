module PacioFp
    class FpCollection < Inferno::TestGroup
      title 'PACIO Functional Performance Collection Tests'
        
      description 'Verify support for the server capabilities required by the Functional Performance Collection profile.'
      id :pacio_fp_collection
  
      input :fp_collection_id
  
      test do
        title 'Server returns correct Functional Performance Collection resource from the read interaction'
        description %(
          This test will verify that Functional Performance Collection resources can be read from the server.
        )
  
      makes_request :collection
  
      run do
        fhir_read(:collection, fp_collection_id, name: :collection)
  
        assert_response_status(200)
          assert_resource_type(:collection)
          assert resource.id == fp_collection_id,
                 "Requested resource with id #{fp_collection_id}, received resource with id #{resource.id}"
        end
      end
  
      test do
        title 'Server returns Functional Performance Collection resoure that matches the PACIO Functional Performance Collection profile'
        description %(
          This test will validate that the Functional Performance Collection resource returned from the server matches the PACIO Functional Performance Collection profile.
        )
        uses_request :collection
        
        run do
          assert_valid_resource(profile_url: 'http://hl7.org/fhir/us/pacio-fp/StructureDefinition/fp-collection')
        end
      end
  
  
      test do
        title 'Server supports searching PACIO Functional Performance Collection profile by ID'
        description %(
          This test will validate that the FHIR server supports searching PACIO Functional Performance Collection profile by ID.
        )
  
        uses_request :collection
  
        run do
          fhir_search :collection, params: { _id: resource.id }
  
          assert_response_status(200)
          assert_resource_type('Bundle')
        end
      end
  
    end
  end