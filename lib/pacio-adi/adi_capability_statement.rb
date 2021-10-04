module PacioAdi
    class AdiCapabilityStatement < Inferno::TestGroup

      title 'ADI Capability Statement Test'

      require "logger"
      logger = Logger.new(STDOUT)
        
      description 'Verify the server incluldes capability statement required by the ADI Document Reference profile.'
      id :pacio_adi_capability_statement
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



      test do
        id :capability_statement_read
        title 'Read CapabilityStatement'
        description 'Read CapabilityStatement from /metadata endpoint'

        run do
          fhir_get_capability_statement

          assert_response_status(200)
          assert_resource_type(:capability_statement)
        end
      end
      
  
    end
  end