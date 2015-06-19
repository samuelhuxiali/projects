DROP DATABASE IF EXISTS forum;
CREATE DATABASE forum;
\c forum


INSERT INTO users
  (name, email, password, created_at)
  VALUES
  ('Samuel Hu', 'samuelhuxiali@gmail.com', '19880727hu', CURRENT_TIMESTAMP);


INSERT INTO topics
  (topic, popular, created_at)
VALUES
  ('Car', 0, CURRENT_TIMESTAMP),
  ('job', 0, CURRENT_TIMESTAMP),
  ('life', 0, CURRENT_TIMESTAMP);


