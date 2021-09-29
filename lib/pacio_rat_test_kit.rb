Dir.glob(File.join(__dir__, 'pacio-rat', '*.rb')).each { |path| require_relative path.delete_prefix("#{__dir__}/") }

module PacioRat
  class Suite < Inferno::TestSuite
    id :test_suite_template #should I keep id as test_suite_template or rename it to something like test_suite_rat?
    title 'PACIO Re-assessment Timepoints'
    description 'PACIO Re-assessment Timepoints'

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
      title 'Re-assessment Timepoints Resources'

      group from: :pacio_rat_patient
      group from: :pacio_rat_encounter
    end

    # Tests and TestGroups can be written in separate files and then included
    # using their id
    #group from: :patient_group
  end
end
