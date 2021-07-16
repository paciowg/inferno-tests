module PacioRat
  class Patient < Inferno::TestGroup
    title 'Patient (PACIO Re-assessment Timepoints Tests'
      
    description 'Verify support for the server capabilities required by the Patient profile.'
    id :pacio_rat_patient

    test do
      title 'Server returns correct Patient resource from the Patient read interaction'
      description %(
        This test will verify that Patient resources can be read from the server.
      )
      # link https://www.hl7.org/fhir/us/core/StructureDefinition-us-core-patient

    input :patient_id
    makes_request :patient

    run do
      fhir_read(:patient, patient_id, name: :patient)

      assert_response_status(200)
        assert_resource_type(:patient)
        assert resource.id == patient_id,
               "Requested resource with id #{patient_id}, received resource with id #{resource.id}"
      end
    end

    test do
      title 'Server returns Patient resoure that matches the Patient (PACIO Re-assessment Timepoints) profile'
      description %(
        This test will validate that the Patient resource returned from the server matches the Patient (PACIO Re-assessment Timepoints) profile.
      )
      # link https://www.hl7.org/fhir/us/core/StructureDefinition-us-core-patient
      uses_request :patient

      run do
        assert_valid_resource(profile_url: 'https://www.hl7.org/fhir/us/core/StructureDefinition-us-core-patient')
      end
    end
  end
end