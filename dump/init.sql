CREATE USER 'gnf_user'@'%' IDENTIFIED BY 'L1v3rT4st3s4wfull!';
GRANT SELECT, INSERT, UPDATE,DROP,DELETE,CREATE ON *.* TO 'gnf_user'@'%';
FLUSH PRIVILEGES;
