module PacioAdi
    class CareExperiencePreference < Inferno::TestGroup
      title 'Care Experience Preference (PACIO Advance Directives) Tests'
        
      description 'Verify support for the server capabilities required by the Care Experience Preference profile.'
      id :pacio_adi_care_experience_preference
  
      test do
        title 'Server returns correct Care Experience Preference resource from the Care Experience Preference read interaction'
        description %(
          This test will verify that Care Experience Preference resources can be read from the server.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-CareExperiencePreference
  
      input :care_experience_preference_id
      makes_request :care_experience_preference
  
      run do
        fhir_read(:goal, care_experience_preference_id, name: :care_experience_preference)
  
        assert_response_status(200)
          assert_resource_type(:goal)
          assert resource.id == care_experience_preference_id,
                 "Requested resource with id #{care_experience_preference_id}, received resource with id #{resource.id}"
        end
      end
  
      test do
        title 'Server returns Care Experience Preference resoure that matches the Care Experience Preference (PACIO Advance Directives) profile'
        description %(
          This test will validate that the Care Experience Preference resource returned from the server matches the Care Experience Preference (PACIO Advance Directives) profile.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-CareExperiencePreference
        uses_request :care_experience_preference
  
        run do
          assert_valid_resource(profile_url: 'http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-CareExperiencePreference')
        end
      end
  
    end
  end