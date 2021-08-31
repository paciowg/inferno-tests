module PacioAdi
    class OrganDonation < Inferno::TestGroup
      title 'Organ Donation (PACIO Advance Directives) Tests'
        
      description 'Verify support for the server capabilities required by the Organ Donation profile.'
      id :pacio_adi_organ_donation
  
      test do
        title 'Server returns correct Organ Donation resource from the Organ Donation read interaction'
        description %(
          This test will verify that Organ Donation resources can be read from the server.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-OrganDonationObservation
  
      input :organ_donation_id
      makes_request :organ_donation
  
      run do
        fhir_read(:organ_donation, organ_donation_id, name: :organ_donation)
  
        assert_response_status(200)
          assert_resource_type(:organ_donation)
          assert resource.id == organ_donation_id,
                 "Requested resource with id #{organ_donation_id}, received resource with id #{resource.id}"
        end
      end
  
      test do
        title 'Server returns Organ Donation resoure that matches the Organ Donation (PACIO Advance Directives) profile'
        description %(
          This test will validate that the Organ Donation resource returned from the server matches the Organ Donation (PACIO Advance Directives) profile.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-OrganDonationObservation
        uses_request :organ_donation
  
        run do
          assert_valid_resource(profile_url: 'http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-OrganDonationObservation')
        end
      end
  
      test do
        title 'Server supports searching Organ Donation (PACIO Advance Directives) profile by Organ Donation ID'
        description %(
          This test will validate that the FHIR server supports searching Organ Donation by ID (PACIO Advance Directives) profile.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-OrganDonationObservation
  
        uses_request :organ_donation
  
        run do
          fhir_search :organ_donation, params: { _id: resource.id }
  
          assert_response_status(200)
          assert_resource_type('Bundle')
        end
      end
  
    end
  end