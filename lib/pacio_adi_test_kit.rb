Dir.glob(File.join(__dir__, 'pacio-adi', '*.rb')).each { |path| require_relative path.delete_prefix("#{__dir__}/") }

module PacioAdi
  class Suite < Inferno::TestSuite
    id :test_suite_adi
    title 'PACIO Advance Directives'
    description 'PACIO Advance Directives'

    # This input will be available to all tests in this suite
    input :url

    # All FHIR requests in this suite will use this FHIR client
    fhir_client do
      url :url
    end

    # Tests and TestGroups can be defined inline
    group do
      id :capability_statement
      title 'Capability Statement'
      description 'Verify that the server has a CapabilityStatement'


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

    group do
      title 'Advance Directives'

      #todo: uncomment when done
      #group from: :pacio_adi_patient
      #group from: :pacio_adi_organ_donation
      #group from: :pacio_adi_personal_goal
      #group from: :pacio_adi_adi_provenance
      #group from: :pacio_adi_care_experience_preference
      #group from: :pacio_adi_personal_priorities_organizer
      #group from: :pacio_adi_autopsy_observation
      #group from: :pacio_adi_personal_intervention_preference
      #group from: :pacio_adi_pmolst_observation
      #group from: :pacio_adi_healthcare_agent_consent
      #group from: :pacio_adi_healthcare_agent
      #group from: :pacio_adi_personal_advance_care_plan_composition
      #group from: :pacio_adi_header
      group from: :pacio_adi_document_reference

    end

    # Tests and TestGroups can be written in separate files and then included
    # using their id
    #group from: :patient_group
  end
end
