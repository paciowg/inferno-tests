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
      title 'PACIO Advance Directives Interoperability (ADI) Tests'

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
      group from: :pacio_adi_capability_statement
      group from: :pacio_adi_document_reference

    end

    # Tests and TestGroups can be written in separate files and then included
    # using their id
    #group from: :patient_group
  end
end
