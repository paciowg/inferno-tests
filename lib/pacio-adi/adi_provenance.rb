module PacioAdi
    class AdiProvenance < Inferno::TestGroup
      title 'ADI Provenance (PACIO Advance Directives) Tests'
        
      description 'Verify support for the server capabilities required by the ADI Provenance profile.'
      id :pacio_adi_adi_provenance
  
      test do
        title 'Server returns correct ADI Provenance resource from the ADI Provenance read interaction'
        description %(
          This test will verify that ADI Provenance resources can be read from the server.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-Provenance
  
      input :adi_provenance_id
      makes_request :adi_provenance
  
      run do
        fhir_read(:USCoreProvenance, adi_provenance_id, name: :adi_provenance)
  
        assert_response_status(200)
          assert_resource_type(:USCoreProvenance)
          assert resource.id == adi_provenance_id,
                 "Requested resource with id #{adi_provenance_id}, received resource with id #{resource.id}"
        end
      end
  
      test do
        title 'Server returns ADI Provenance resoure that matches the ADI Provenance (PACIO Advance Directives) profile'
        description %(
          This test will validate that the ADI Provenance resource returned from the server matches the ADI Provenance (PACIO Advance Directives) profile.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-Provenance
        uses_request :adi_provenance
  
        run do
          assert_valid_resource(profile_url: 'http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-Provenance')
        end
      end
  
    end
  end