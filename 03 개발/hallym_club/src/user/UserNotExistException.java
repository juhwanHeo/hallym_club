package user;

public class UserNotExistException extends Exception{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3614275611589007042L;

	public UserNotExistException(String m) {
		super(m);
	}
}