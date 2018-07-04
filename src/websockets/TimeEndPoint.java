package websockets;

import java.util.Date;

import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/time")
public class TimeEndPoint {
	
	@OnOpen
	public void runThread(final Session session) {
		Thread childThread = new Thread(new Runnable() {

			@Override
			public void run() {
				while(true) {
					try {
						
						session.getBasicRemote().sendText(new Date().toString());
						Thread.sleep(5000);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		});
		childThread.start();
	}
}
