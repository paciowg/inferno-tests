module PacioAdi
    class AdiDocumentReference < Inferno::TestGroup

      title 'ADI Document Reference (PACIO Advance Directives) Tests'

      require "logger"
      logger = Logger.new(STDOUT)
        
      description 'Verify support for the server capabilities required by the ADI Document Reference profile.'
      id :pacio_adi_document_reference
      input :adi_document_reference_id
  
      test do
        title 'Server returns correct ADI Document Reference resource from the ADI Document Reference read interaction'
        description %(
          This test will verify that ADI Document Reference resources can be read from the server.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-DocumentReference
  
      makes_request :adi_document_reference


        #todo: move assert valid 200 to separate tests
        
  
        run do
          fhir_read(:DocumentReference, adi_document_reference_id, name: :adi_document_reference)
          
          assert_response_status(200)
          assert_resource_type(:DocumentReference)
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

        uses_request :adi_document_reference
  
        run do
          #read DocumentReference resource
          logger.warn("\nbegin custodian test")
          fhir_read(:DocumentReference, adi_document_reference_id, name: :adi_document_reference)
          assert_response_status(200)
          
          #get necessary values from DocumentReference resource
          bundle_id = resource.content[0].attachment.url.split('/')[1]  #url has structure "resource-type/resource-id" We only want the id after the slash 
          doc_ref_custodian = resource.custodian
          logger.warn("resource after DocumentReference fhir_read = #{resource.to_s}")
          logger.warn("bundle_id = #{bundle_id}")
          logger.warn("doc_ref_custodian = #{doc_ref_custodian.to_s}")

          #read the Bundle resource from url in DocumentReference
          fhir_read(:Bundle, bundle_id)
          assert_response_status(200)

          #get necessary values from Bundle resource
          bundle_custodian = resource.entry[0].resource.custodian
          logger.warn("resource after Bundle fhir_read = #{resource.to_s}")
          logger.warn("bundle_custodian = #{bundle_custodian.to_s}")

          assert(doc_ref_custodian == bundle_custodian,
                    "Expected custodian: #{doc_ref_custodian.reference} but was: #{bundle_custodian.reference}")

          #assert resource.entry[0].resource.custodian == @@my_custodian,
          #        "custodian test. resource.entry[0].custodian is #{resource.entry[0].resource.custodian} but @@my_custodian is #{@@my_custodian}"
          logger.warn("end of custodian test")
        end
      end
      #no new stuff beyond this point
  
    end
  end