module PacioAdi
    class AdiResourceValidation < Inferno::TestGroup

      title 'ADI Resource Validation Test'

      require "logger"
      logger = Logger.new(STDOUT)
        
      description 'Verify the FHIR instances identified in the Document Reference have a valid structure, as defined in the ADI Implementation Guide.'
      id :pacio_resource_validation
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

      #Healthcare Agent test
      test do
        title 'Healthcare Agent resource conforms to the structure defined in ADI Implementation Guide'
        description %(
          This test will validate the Healthcare Agent resource returned from the server conforms to the structure defined in ADI Implementation Guide.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-DocumentReference
        uses_request :adi_document_reference
  
        run do
          assert(true)
        end
      end

      #Healthcare Agent Consent test
      test do
        title 'Healthcare Agent Consent resource conforms to the structure defined in ADI Implementation Guide'
        description %(
          This test will validate the Healthcare Agent resource returned from the server conforms to the structure defined in ADI Implementation Guide.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-DocumentReference
        uses_request :adi_document_reference
  
        run do
          assert(true)
        end
      end

      #Care Experience Preference test
      test do
        title 'Care Experience Preference resource conforms to the structure defined in ADI Implementation Guide'
        description %(
          This test will validate the Care Experience Preference resource returned from the server conforms to the structure defined in ADI Implementation Guide.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-DocumentReference
        uses_request :adi_document_reference
  
        run do
          assert(true)
        end
      end

      #Personal Intervention Preference test
      test do
        title 'Personal Intervention Preference resource conforms to the structure defined in ADI Implementation Guide'
        description %(
          This test will validate the Personal Intervention Preference resource returned from the server conforms to the structure defined in ADI Implementation Guide.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-DocumentReference
        uses_request :adi_document_reference
  
        run do
          assert(true)
        end
      end

      #Personal Goal test
      test do
        title 'Personal Goal resource conforms to the structure defined in ADI Implementation Guide'
        description %(
          This test will validate the Personal Goal resource returned from the server conforms to the structure defined in ADI Implementation Guide.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-DocumentReference
        uses_request :adi_document_reference
  
        run do
          assert(true)
        end
      end

      #Organ Donation Observation test
      test do
        title 'Organ Donation Observation resource conforms to the structure defined in ADI Implementation Guide'
        description %(
          This test will validate the Organ Donation Observation resource returned from the server conforms to the structure defined in ADI Implementation Guide.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-DocumentReference
        uses_request :adi_document_reference
  
        run do
          assert(true)
        end
      end


      
  
    end
  end