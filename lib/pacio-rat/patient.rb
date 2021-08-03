module PacioRat
  class Patient < Inferno::TestGroup
    title 'Patient (PACIO Re-assessment Timepoints) Tests'
      
    description 'Verify support for the server capabilities required by the Patient profile.'
    id :pacio_rat_patient

    input :patient_id

    test do
      title 'Server returns correct Patient resource from the Patient read interaction'
      description %(
        This test will verify that Patient resources can be read from the server.
      )
      # link http://hl7.org/fhir/us/core/structuredefinition/us-core-patient

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
      # link http://hl7.org/fhir/us/core/structuredefinition/us-core-patient
      uses_request :patient

      run do
        assert_valid_resource(profile_url: 'http://hl7.org/fhir/us/core/structuredefinition/us-core-patient')
      end
    end

    test do
      title 'Server supports searching Patient (PACIO Re-assessment Timepoints) profile by patient ID'
      description %(
        This test will validate that the FHIR server supports searching Patient by ID (PACIO Re-assessment Timepoints) profile.
      )
      # link http://hl7.org/fhir/us/core/structuredefinition/us-core-patient

      uses_request :patient

      run do
        fhir_search :patient, params: { _id: resource.id }

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

  end
end