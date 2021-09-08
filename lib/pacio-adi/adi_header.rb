module PacioAdi
    class AdiHeader < Inferno::TestGroup
      title 'ADI Header (PACIO Advance Directives) Tests'
        
      description 'Verify support for the server capabilities required by the ADI Header profile.'
      id :pacio_adi_header
  
      test do
        title 'Server returns correct ADI Header resource from the ADI Header read interaction'
        description %(
          This test will verify that ADI Header resources can be read from the server.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-Header
  
      input :adi_header_id
      makes_request :adi_header
  
      run do
        fhir_read(:clinicaldocument, adi_header_id, name: :adi_header)
  
        assert_response_status(200)
          assert_resource_type(:clinicaldocument)
          assert resource.id == adi_header_id,
                 "Requested resource with id #{adi_header_id}, received resource with id #{resource.id}"
        end
      end
  
      test do
        title 'Server returns ADI Header resoure that matches the ADI Header (PACIO Advance Directives) profile'
        description %(
          This test will validate that the ADI Header resource returned from the server matches the ADI Header (PACIO Advance Directives) profile.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-Header
        uses_request :adi_header
  
        run do
          assert_valid_resource(profile_url: 'http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-Header')
        end
      end
  
    end
  end