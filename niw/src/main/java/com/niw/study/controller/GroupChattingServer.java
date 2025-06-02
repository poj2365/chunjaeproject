package com.niw.study.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArraySet;

import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.niw.study.model.dto.Message;
import com.niw.study.model.dto.MessageDeSerializer;
import com.niw.study.model.dto.MessageSerializer;
import com.niw.study.model.service.GroupChatService;

@ServerEndpoint(
    value = "/study/groupchat",
    encoders = {MessageSerializer.class},
    decoders = {MessageDeSerializer.class}
)
public class GroupChattingServer {

    // 그룹별 세션 저장: groupNumber -> 해당 그룹의 Session 목록
    private static final ConcurrentHashMap<Integer, Set<Session>> groupSessions = new ConcurrentHashMap<>();

    @OnOpen
    public void open(Session session, EndpointConfig config) {
        System.out.println("클라이언트 접속: " + session.getId());

        // 쿼리 파라미터에서 groupNumber 추출
        String query = session.getQueryString();
        if (query != null && query.startsWith("groupNumber=")) {
            int groupNumber = Integer.parseInt(query.split("=")[1]);

			// 세션을 그룹에 등록
			groupSessions.computeIfAbsent(groupNumber, k -> new CopyOnWriteArraySet<>()).add(session);

			// 그룹 번호 세션 속성에 저장
			session.getUserProperties().put("groupNumber", groupNumber);
			
        } else {
            try {
                session.getBasicRemote().sendText("그룹 번호를 URL 파라미터로 전달해야 합니다.");
                session.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

        @OnMessage
        public void message(Session session, Message msg) {
            System.out.println("받은 메시지: " + msg);

            int groupNumber = msg.getGroupNumber();
            switch (msg.getType()) {
                case "A":
                   // sendAlram(groupNumber, msg);
                    break;
                case "M":
                    sendChatMsg(groupNumber, msg);
                    break;
                default:
                    System.out.println("알 수 없는 메시지 타입: " + msg.getType());
            }
        }

        @OnClose
        public void onClose(Session session) {
            Integer groupNumber = (Integer) session.getUserProperties().get("groupNumber");
            if (groupNumber != null) {
                Set<Session> groupSet = groupSessions.get(groupNumber);
                if (groupSet != null) {
                    groupSet.remove(session);
                }
            }
            System.out.println("클라이언트 연결 종료: " + session.getId());
        }


    private void sendChatMsg(int groupNumber, Message msg) {
        if (msg.getMessage() == null || msg.getMessage().trim().isEmpty()) return;
        broadcast(groupNumber, msg);
    }

    private void broadcast(int groupNumber, Message msg) {
        Set<Session> groupClients = groupSessions.get(groupNumber);
        if (groupClients != null) {
            for (Session client : groupClients) {
                if (client.isOpen()) {
                    try {
                        client.getBasicRemote().sendText(msg.toJson());
                        if(msg.getType().equals("M")) {
                        	int result = GroupChatService.SERVICE.insertGroupChat(msg);
                        }
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }
}