package websockets;

import javax.websocket.OnMessage;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/upper")
public class Upper {

	@OnMessage
	public void onMessage(Session session, String message) {
		try {
			session.getBasicRemote().sendText(message.toUpperCase());
		}
		catch(Exception e) {}
	}
	
}
