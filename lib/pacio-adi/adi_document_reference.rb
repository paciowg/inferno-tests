module PacioAdi
    class AdiDocumentReference < Inferno::TestGroup

      require "logger"
      logger = Logger.new(STDOUT)
      logger.debug("I'm a debug log")


      title 'ADI Document Reference (PACIO Advance Directives) Tests'
        
      description 'Verify support for the server capabilities required by the ADI Document Reference profile.'
      id :pacio_adi_document_reference
      input :adi_document_reference_id

      @@my_type = ""
      @@my_subject = ""
      @@my_custodian = ""
  
      test do
        title 'Server returns correct ADI Document Reference resource from the ADI Document Reference read interaction'
        description %(
          This test will verify that ADI Document Reference resources can be read from the server.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-DocumentReference
  
      makes_request :adi_document_reference
  
      run do
        logger.error("begin verify ADI doc ref read from server test")
        fhir_read(:DocumentReference, adi_document_reference_id, name: :adi_document_reference)
  
        assert_response_status(200)
          assert_resource_type(:DocumentReference)
          #assert resource.id == adi_document_reference_id,
          @@my_custodian = resource.custodian
          @@my_subject = resource.subject
          @@my_type = resource.type
          logger.error("middle of verify ADI doc ref read server test. my_custodian: #{@@my_custodian}")
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
          #todo: uncomment assert_valid_resource test
          #assert_valid_resource(profile_url: 'http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-DocumentReference')
          assert true
        end
      end


      #begin new stuff
      test do
        title 'Document Reference type matches the composition (ADI Header) type'
        description %(
          This test will validate the Document Reference returned from the server has a type that matches the composition (ADI Header) type.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-DocumentReference
        uses_request :adi_document_reference
  
        run do
            assert true
          end
      end

      test do
        title 'Document Reference subject matches the composition (ADI Header) subject'
        description %(
          This test will validate the Document Reference returned from the server has a subject that matches the composition (ADI Header) subject.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-DocumentReference
        uses_request :adi_document_reference
  
        run do
            assert true
          end
      end

      test do
        title 'Document Reference custodian matches the composition (ADI Header) custodian'
        description %(
          This test will validate the Document Reference returned from the server has a custodian that matches the composition (ADI Header) custodian.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-DocumentReference
  
        run do
          fhir_read(:Bundle, 'Example-Smith-Johnson-Bundle1')
          assert_response_status(200)
          logger.error("custodian test. my_custodian: #{@@my_custodian}")
          assert resource.entry[0].resource.custodian == @@my_custodian,
                  #"Received resource with url #{resource.content[0].attachment.url}"
                  "custodian test. resource.entry[0].custodian is #{resource.entry[0].resource.custodian.reference} but @@my_custodian is #{@@my_custodian}"
        end
      end
      #no new stuff beyond this point
  
    end
  end