Dir.glob(File.join(__dir__, 'pacio-fp', '*.rb')).each { |path| require_relative path.delete_prefix("#{__dir__}/") }

module PacioFp
  class Suite < Inferno::TestSuite
    id :test_suite_fp
    title 'PACIO Functional Performance'
    description 'PACIO Functional Performance (FP)'

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
      title 'Functional Performance'

      group from: :pacio_fp_observation
      group from: :pacio_fp_collection
      group from: :pacio_fp_narrative_history_of_status 
      group from: :pacio_fp_use_of_device 

    end

    # Tests and TestGroups can be written in separate files and then included
    # using their id
    #group from: :patient_group
  end
end
