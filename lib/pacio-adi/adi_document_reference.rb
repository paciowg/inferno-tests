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


        #todo: move assert valid 200 response code to separate tests
        
  
        run do
          logger.warn("") #whitespace for readable logs
          logger.warn("begin DocumentReference read test")
          fhir_read(:DocumentReference, adi_document_reference_id, name: :adi_document_reference)
          
          assert_response_status(200)
          assert_resource_type(:DocumentReference)
          assert resource.id == adi_document_reference_id,
                 "Requested resource with id #{adi_document_reference_id}, received resource with id #{resource.id}"
          logger.warn("end of DocumentReference read test")
        end
      end

      #patient test
      test do
        title 'Patient resource conforms to the structure defined in ADI Implementation Guide'
        description %(
          This test will validate the patient resource returned from the server conforms to the structure defined in ADI Implementation Guide.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-DocumentReference
        uses_request :adi_document_reference
  
        run do
          logger.warn("") #whitespace for readable logs
          logger.warn("begin patient test")
          fhir_read(:DocumentReference, adi_document_reference_id, name: :adi_document_reference)
          assert_response_status(200)
          
          #get necessary values from DocumentReference resource
          patient_id = resource.subject.reference.split('/')[1]  #url has structure "resource-type/resource-id" We only want the id after the slash 
          logger.warn("resource after DocumentReference fhir_read = #{resource.to_s}")
          logger.warn("patient_id = #{patient_id}")

          fhir_read(:Patient, patient_id)
          logger.warn("resource after Patient fhir_read = #{resource.to_s}")

          assert_valid_resource(profile_url: 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient')

          logger.warn("end of patient test")
        end
      end

      #type test
      test do
        title 'Document Reference type matches the composition (ADI Header) type'
        description %(
          This test will validate the Document Reference returned from the server has a type that matches the composition (ADI Header) type.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-DocumentReference
        uses_request :adi_document_reference
  
        run do
          #read DocumentReference resource
          logger.warn("") #whitespace for readable logs
          logger.warn("begin type test")
          fhir_read(:DocumentReference, adi_document_reference_id, name: :adi_document_reference)
          assert_response_status(200)
          
          #get necessary values from DocumentReference resource
          bundle_id = resource.content[0].attachment.url.split('/')[1]  #url has structure "resource-type/resource-id" We only want the id after the slash 
          doc_ref_type = resource.type
          logger.warn("resource after DocumentReference fhir_read = #{resource.to_s}")
          logger.warn("bundle_id = #{bundle_id}")
          logger.warn("doc_ref_type = #{doc_ref_type.to_s}")

          #read the Bundle resource from url in DocumentReference
          fhir_read(:Bundle, bundle_id)
          assert_response_status(200)

          #get necessary values from Bundle resource
          bundle_type = resource.entry[0].resource.type
          logger.warn("resource after Bundle fhir_read = #{resource.to_s}")
          logger.warn("bundle_type = #{bundle_type.to_s}")

          assert(doc_ref_type == bundle_type,
                    "Expected type: #{doc_ref_type.coding[0].code} but was: #{bundle_type.coding[0].code}")

          logger.warn("end of type test")
        end
      end

      #subject test
      test do
        title 'Document Reference subject matches the composition (ADI Header) subject'
        description %(
          This test will validate the Document Reference returned from the server has a subject that matches the composition (ADI Header) subject.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-DocumentReference
        uses_request :adi_document_reference
  
        run do
          #read DocumentReference resource
          logger.warn("") #whitespace for readable logs
          logger.warn("begin subject test")
          fhir_read(:DocumentReference, adi_document_reference_id, name: :adi_document_reference)
          assert_response_status(200)
          
          #get necessary values from DocumentReference resource
          bundle_id = resource.content[0].attachment.url.split('/')[1]  #url has structure "resource-type/resource-id" We only want the id after the slash 
          doc_ref_subject = resource.subject
          logger.warn("resource after DocumentReference fhir_read = #{resource.to_s}")
          logger.warn("bundle_id = #{bundle_id}")
          logger.warn("doc_ref_subject = #{doc_ref_subject.to_s}")

          #read the Bundle resource from url in DocumentReference
          fhir_read(:Bundle, bundle_id)
          assert_response_status(200)

          #get necessary values from Bundle resource
          bundle_subject = resource.entry[0].resource.subject
          logger.warn("resource after Bundle fhir_read = #{resource.to_s}")
          logger.warn("bundle_subject = #{bundle_subject.to_s}")

          assert(doc_ref_subject == bundle_subject,
                    "Expected subject: #{doc_ref_subject.reference} but was: #{bundle_subject.reference}")

          logger.warn("end of subject test")
        end
      end

      #custodian test
      test do
        title 'Document Reference custodian matches the composition (ADI Header) custodian'
        description %(
          This test will validate the Document Reference returned from the server has a custodian that matches the composition (ADI Header) custodian.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-DocumentReference
        uses_request :adi_document_reference
  
        run do
          #read DocumentReference resource
          logger.warn("") #whitespace for readable logs
          logger.warn("begin custodian test")
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

          logger.warn("end of custodian test")
        end
      end
  
    end
  end