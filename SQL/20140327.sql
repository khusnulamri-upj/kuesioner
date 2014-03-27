/*sisfo*/
SELECT *
FROM jadwal j
WHERE j.TahunID = 20131
AND j.NA = 'N'
ORDER BY j.TahunID, j.KodeID, j.ProgramID, j.ProdiID, j.MKKode, j.Nama, j.HariID, j.JamMulai, j.JamSelesai, j.RuangID, j.DosenID;

SELECT *
FROM jadwal j
WHERE j.TahunID = 20131
AND j.NA = 'N'
GROUP BY j.TahunID, j.KodeID, j.ProgramID, j.ProdiID, j.MKKode, j.Nama, j.HariID, j.JamMulai, j.JamSelesai, j.RuangID, j.DosenID
ORDER BY j.TahunID, j.KodeID, j.ProgramID, j.ProdiID, j.MKKode, j.Nama, j.HariID, j.JamMulai, j.JamSelesai, j.RuangID, j.DosenID;

SELECT *
FROM jadwal j
WHERE j.TahunID = 20131
AND j.NA = 'N'
GROUP BY j.TahunID, j.KodeID, j.MKKode, j.Nama, j.HariID, j.JamMulai, j.JamSelesai, j.RuangID, j.DosenID
ORDER BY j.TahunID, j.KodeID, j.MKKode, j.Nama, j.HariID, j.JamMulai, j.JamSelesai, j.RuangID, j.DosenID;

SELECT *
FROM jadwaldosen jd;

SELECT *
FROM jadwal j
RIGHT OUTER JOIN jadwaldosen jd ON j.JadwalID = jd.JadwalID
LEFT OUTER JOIN mk ON j.MKID = mk.MKID
LEFT OUTER JOIN hari h ON j.HariID = h.HariID
LEFT OUTER JOIN dosen d ON j.DosenID = d.Login
WHERE j.TahunID = 20131
AND j.NA = 'N';

/*
jadwal yang aktif
hanya tipe kuliah saja, bukan lab, responsi atau tutorial
*/
SELECT jj.TahunID, jj.KodeID, jj.ProgramID, jj.ProdiID, jj.MKID,
UPPER(mk.MKKode) AS MKKode, UPPER(mk.Nama) AS nama_mk, jj.HariID, h.Nama AS hari, jj.JamMulai,
SUBSTRING(jj.JamMulai,1,5) AS jam_mulai, jj.JamSelesai, SUBSTRING(jj.JamSelesai,1,5) AS jam_selesai, jj.RuangID, jj.DosenID,
d.Nama AS nama_dosen, jj.dosen_utama
FROM (
SELECT j.TahunID, j.KodeID, j.ProgramID, j.ProdiID, j.MKID,
j.HariID, j.JamMulai, j.JamSelesai, j.RuangID, j.DosenID, 1 AS dosen_utama
FROM jadwal j
WHERE j.TahunID = '20131'
AND j.NA = 'N'
AND j.JenisJadwalID = 'K'
UNION ALL
SELECT j.TahunID, j.KodeID, j.ProgramID, j.ProdiID, j.MKID,
j.HariID, j.JamMulai, j.JamSelesai, j.RuangID, jd.DosenID, 0 AS dosen_utama
FROM jadwal j
RIGHT OUTER JOIN jadwaldosen jd ON j.JadwalID = jd.JadwalID
WHERE j.TahunID = '20131'
AND j.NA = 'N'
AND j.JenisJadwalID = 'K') jj
LEFT OUTER JOIN mk ON jj.MKID = mk.MKID
LEFT OUTER JOIN hari h ON jj.HariID = h.HariID
LEFT OUTER JOIN dosen d ON jj.DosenID = d.Login
GROUP BY jj.TahunID, UPPER(mk.MKKode), UPPER(mk.Nama), jj.HariID, jj.JamMulai, jj.JamSelesai, jj.RuangID, jj.DosenID
ORDER BY jj.TahunID, UPPER(mk.MKKode), UPPER(mk.Nama), jj.HariID, jj.JamMulai, jj.JamSelesai, jj.RuangID, jj.dosen_utama DESC, d.Nama, jj.DosenID, jj.ProdiID;