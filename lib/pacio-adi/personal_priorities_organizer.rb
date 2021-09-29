module PacioAdi
    class PersonalPrioritiesOrganizer < Inferno::TestGroup
      title 'Personal Priorities Organizer (PACIO Advance Directives) Tests'
        
      description 'Verify support for the server capabilities required by the Personal Priorities Organizer profile.'
      id :pacio_adi_personal_priorities_organizer
  
      test do
        title 'Server returns correct Personal Priorities Organizer resource from the Personal Priorities Organizer read interaction'
        description %(
          This test will verify that Personal Priorities Organizer resources can be read from the server.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-PersonalPrioritiesOrganizer
  
      input :personal_priorities_organizer_id
      makes_request :personal_priorities_organizer
  
      run do
        fhir_read(:list, personal_priorities_organizer_id, name: :personal_priorities_organizer)
  
        assert_response_status(200)
          assert_resource_type(:list)
          assert resource.id == personal_priorities_organizer_id,
                 "Requested resource with id #{personal_priorities_organizer_id}, received resource with id #{resource.id}"
        end
      end
  
      test do
        title 'Server returns Personal Priorities Organizer resoure that matches the Personal Priorities Organizer (PACIO Advance Directives) profile'
        description %(
          This test will validate that the Personal Priorities Organizer resource returned from the server matches the Personal Priorities Organizer (PACIO Advance Directives) profile.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-PersonalPrioritiesOrganizer
        uses_request :personal_priorities_organizer
  
        run do
          assert_valid_resource(profile_url: 'http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-PersonalPrioritiesOrganizer')
        end
      end
  
    end
  end