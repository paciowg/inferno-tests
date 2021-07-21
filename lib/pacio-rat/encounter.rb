module PacioRat
    class Encounter < Inferno::TestGroup
      title 'Encounter (PACIO Re-assessment Timepoints) Tests'
        
      description 'Verify support for the server capabilities required by the Encounter profile.'
      id :pacio_rat_encounter
  
      test do
        title 'Server returns correct Encounter resource from the Encounter read interaction'
        description %(
          This test will verify that Encounter resources can be read from the server.
        )
        # link https://paciowg.github.io/re-assessment-timepoints-ig/StructureDefinition-prat-encounter.html
  
      input :encounter_id
      makes_request :encounter
  
      run do
        fhir_read(:encounter, encounter_id, name: :encounter)
  
        assert_response_status(200)
          assert_resource_type(:encounter)
          assert resource.id == encounter_id,
                 "Requested resource with id #{encounter_id}, received resource with id #{resource.id}"
        end
      end
  
      test do
        title 'Server returns Encounter resoure that matches the Encounter (PACIO Re-assessment Timepoints) profile'
        description %(
          This test will validate that the Encounter resource returned from the server matches the Encounter (PACIO Re-assessment Timepoints) profile.
        )
        # link https://paciowg.github.io/re-assessment-timepoints-ig/StructureDefinition-prat-encounter.html
        uses_request :encounter
  
        run do
          assert_valid_resource(profile_url: 'https://paciowg.github.io/re-assessment-timepoints-ig/StructureDefinition-prat-encounter.html')
        end
      end
    end
  end