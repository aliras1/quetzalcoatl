package quetzalcoatl.caffapplication.auth_user;

import quetzalcoatl.caffapplication.base.AbstractEntity;
import quetzalcoatl.caffapplication.base.auth.Role;

import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import java.util.Set;

@Entity
public class AuthUser extends AbstractEntity {

	private String username;

    private String passwordHash;

    @Enumerated(EnumType.STRING)
    @ElementCollection(fetch = FetchType.EAGER)
    private Set<Role> roles;

    public String getUsername() {
        return username;
    }

    public void setUsername(String email) {
        this.username = email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }
    @Override
    public int hashCode() {
    	final int prime = 31;
    	int result = super.hashCode();
    	result = prime * result + ((passwordHash == null) ? 0 : passwordHash.hashCode());
    	result = prime * result + ((roles == null) ? 0 : roles.hashCode());
    	result = prime * result + ((username == null) ? 0 : username.hashCode());
    	return result;
    }
    
    @Override
    public boolean equals(Object obj) {
    	if (this == obj)
    		return true;
    	if (!super.equals(obj))
    		return false;
    	if (getClass() != obj.getClass())
    		return false;
    	AuthUser other = (AuthUser) obj;
    	if (passwordHash == null) {
    		if (other.passwordHash != null)
    			return false;
    	} else if (!passwordHash.equals(other.passwordHash))
    		return false;
    	if (roles == null) {
    		if (other.roles != null)
    			return false;
    	} else if (!roles.equals(other.roles))
    		return false;
    	if (username == null) {
    		if (other.username != null)
    			return false;
    	} else if (!username.equals(other.username))
    		return false;
    	return true;
    }
}
