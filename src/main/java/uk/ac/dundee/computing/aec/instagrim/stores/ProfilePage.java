/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.ac.dundee.computing.aec.instagrim.stores;

import java.util.UUID;

/**
 *
 * @author Tom
 */
public class ProfilePage {
    String username = null;
    String firstName = null;
    String lastName = null;
    UUID profilePic = null;
    
    public void ProfilePage(){
        
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public UUID getProfilePic() {
        return profilePic;
    }

    public void setProfilePic(UUID profilePic) {
        this.profilePic = profilePic;
    }
}
