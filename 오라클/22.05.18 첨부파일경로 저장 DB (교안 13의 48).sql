-- 22.05.18 

CREATE TABLE ictimage(
    uuid VARCHAR(100) NOT NULL,
    uploadPath VARCHAR(200) NOT NULL,
    fileName VARCHAR(100) NOT NULL,
    fileType char(1) DEFAULT 'I',
    bno number(10)
);

ALTER TABLE ictimage ADD CONSTRAINT pk_attach PRIMARY KEY (uuid);
ALTER TABLE ictimage ADD CONSTRAINT fk_board_attach FOREIGN KEY(bno) REFERENCES board_tbl(bno);

SELECT * FROM ictimage;
commit;

delete from ictimage;

		INSERT INTO ictimage (uuid, uploadpath, filename, filetype, bno)
			VALUES
		('11', '111', '11111', 'I', 196636);

--drop table ictimage;


