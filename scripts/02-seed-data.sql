-- Insert sample data for testing
INSERT INTO users (username, email, password_hash) VALUES 
('regulator', 'regulator@example.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj/RK.PJ/..2'),
('testuser', 'test@example.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj/RK.PJ/..2')
ON CONFLICT (username) DO NOTHING;

INSERT INTO rates (currency_pair, rate) VALUES 
('USD/EUR', 0.85),
('USD/GBP', 0.73),
('USD/JPY', 110.25),
('EUR/GBP', 0.86)
ON CONFLICT DO NOTHING;

INSERT INTO cards (user_id, card_number, card_type, balance) VALUES 
(1, '**** **** **** 1234', 'VISA', 1500.00),
(1, '**** **** **** 5678', 'MASTERCARD', 2300.50),
(2, '**** **** **** 9012', 'VISA', 750.25)
ON CONFLICT DO NOTHING;

INSERT INTO news (title, content, author) VALUES 
('Market Update', 'Currency markets showing stability this week with EUR gaining against USD.', 'Financial Team'),
('New Features Released', 'We have added new card management features to improve your banking experience.', 'Product Team'),
('Security Enhancement', 'Enhanced security measures have been implemented to protect your account.', 'Security Team')
ON CONFLICT DO NOTHING;
