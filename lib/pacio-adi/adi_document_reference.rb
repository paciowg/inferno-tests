module PacioAdi
    class AdiDocumentReference < Inferno::TestGroup
      title 'ADI Document Reference (PACIO Advance Directives) Tests'
        
      description 'Verify support for the server capabilities required by the ADI Document Reference profile.'
      id :pacio_adi_document_reference
  
      test do
        title 'Server returns correct ADI Document Reference resource from the ADI Document Reference read interaction'
        description %(
          This test will verify that ADI Document Reference resources can be read from the server.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-DocumentReference
  
      input :adi_document_reference_id
      makes_request :adi_document_reference
  
      run do
        fhir_read(:uscoredocumentreferenceprofile, adi_document_reference_id, name: :adi_document_reference)
  
        assert_response_status(200)
          assert_resource_type(:uscoredocumentreferenceprofile)
          assert resource.id == adi_document_reference_id,
                 "Requested resource with id #{adi_document_reference_id}, received resource with id #{resource.id}"
        end
      end
  
      test do
        title 'Server returns ADI Document Reference resoure that matches the ADI Document Reference (PACIO Advance Directives) profile'
        description %(
          This test will validate that the ADI Document Reference resource returned from the server matches the ADI Document Reference (PACIO Advance Directives) profile.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-DocumentReference
        uses_request :adi_document_reference
  
        run do
          assert_valid_resource(profile_url: 'http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-DocumentReference')
        end
      end
  
    end
  end