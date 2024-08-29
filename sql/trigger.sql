
-- DROP TRIGGER IF EXISTS pgqueuer_json_trigger ON pgqueuer;

CREATE TRIGGER pgqueuer_json_trigger
  BEFORE INSERT
  ON pgqueuer
  FOR EACH ROW
  EXECUTE PROCEDURE pgqueuer_text_to_json();

-- INSERT INTO pgqueuer (message_id, topic, text, qos, retain) values (1, 'topic', '{"a": "json"}', 1, 0);
-- SELECT * FROM pgqueuer;
