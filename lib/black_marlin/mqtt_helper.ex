defmodule MqttHelper do
  @begin 0

  # Related to MqttClient
  @clientId  1
  @clientPId 2
  @username 3
  @peername 4
  @cleanSession 5
  @protoVersion 6
  @keepAlive 7
  @willTopic 8
  @wsInitialHeaders 9
  @mountPoint 10
  @connectedAt 11

  # Related to MqttMessage
  @id  1
  @packetId 2
  @from 3
  @topic 4
  @qos 5
  @flags 6
  @retain 7
  @dup 8
  @sys 9
  @headers 10
  @payload 11
  @timestamp 12

  def get_mq_client_id(data) do
    iterate_client_item(@begin, @clientId, Tuple.to_list(data))
  end

  def get_mq_client_pid(data) do
    iterate_client_item(@begin, @clientPId, Tuple.to_list(data))
  end

  def get_mq_client_username(data) do
    iterate_client_item(@begin, @username, Tuple.to_list(data))
  end

  def get_mq_client_peernamee(data) do
    iterate_client_item(@begin, @peername, Tuple.to_list(data))
  end

  def get_mq_client_clean_session(data) do
    iterate_client_item(@begin, @cleanSession, Tuple.to_list(data))
  end

  def get_mq_client_proto_version(data) do
    iterate_client_item(@begin, @protoVersion, Tuple.to_list(data))
  end

  def get_mq_client_keepalive(data) do
    iterate_client_item(@begin, @keepAlive, Tuple.to_list(data))
  end

  def get_mq_client_will_topic(data) do
    iterate_client_item(@begin, @willTopic, Tuple.to_list(data))
  end

  def get_mq_client_ws_initial_headers(data) do
    iterate_client_item(@begin, @wsInitialHeaders, Tuple.to_list(data))
  end

  def get_mq_client_mount_point(data) do
    iterate_client_item(@begin, @mountPoint, Tuple.to_list(data))
  end

  def get_mq_client_connected_at(data) do
    iterate_client_item(@begin, @connectedAt, Tuple.to_list(data))
  end

  defp iterate_client_item(now, target, data) when now == target do
    hd data
  end

  defp iterate_client_item(now, target, data) do
    data = tl data
    iterate_client_item(now + 1, target, data)
  end

  def get_mq_msg_id(data) do
    iterate_message_item(@begin, @id, Tuple.to_list(data))
  end

  def get_mq_msg_packet_id(data) do
    iterate_message_item(@begin, @packetId, Tuple.to_list(data))
  end

  def get_mq_msg_from(data) do
    iterate_message_item(@begin, @from, Tuple.to_list(data))
  end

  def get_mq_msg_topic(data) do
    iterate_message_item(@begin, @topic, Tuple.to_list(data))
  end

  def get_mq_msg_qos(data) do
    iterate_message_item(@begin, @qos, Tuple.to_list(data))
  end

  def get_mq_msg_flags(data) do
    iterate_message_item(@begin, @flags, Tuple.to_list(data))
  end

  def get_mq_msg_retain(data) do
    iterate_message_item(@begin, @retain, Tuple.to_list(data))
  end

  def get_mq_msg_dup(data) do
    iterate_message_item(@begin, @dup, Tuple.to_list(data))
  end

  def get_mq_msg_sys(data) do
    iterate_message_item(@begin, @sys, Tuple.to_list(data))
  end

  def get_mq_msg_headers(data) do
    iterate_message_item(@begin, @headers, Tuple.to_list(data))
  end

  def get_mq_msg_payload(data) do
    iterate_message_item(@begin, @payload, Tuple.to_list(data))
  end

  def get_mq_msg_timestamp(data) do
    iterate_message_item(@begin, @timestamp, Tuple.to_list(data))
  end

  defp iterate_message_item(now, target, data) when now == target do
    hd data
  end

  defp iterate_message_item(now, target, data) do
    data = tl data
    iterate_message_item(now + 1, target, data)
  end
end
