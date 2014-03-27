SELECT a.TahunID, a.KodeID, a.ProgramID, a.ProdiID, a.MKID,
UPPER(a.MKKode) AS MKKode, UPPER(a.Nama_MK) AS nama_mk, a.HariID, a.Hari AS hari, a.JamMulai,
SUBSTRING(a.JamMulai,1,5) AS jam_mulai, a.JamSelesai, SUBSTRING(a.JamSelesai,1,5) AS jam_selesai, a.RuangID, a.DosenID,
a.Nama_Dosen AS nama_dosen, a.order_no AS dosen_utama
            FROM (
            SELECT j.JadwalID, j.KodeID, j.TahunID, j.ProdiID, j.ProgramID, j.MKID, j.MKKode, j.Nama AS Nama_MK, j.HariID, h.Nama AS Hari, j.JamMulai, j.JamSelesai, j.RuangID,
            j.DosenID, d.Nama AS Nama_Dosen, 1 AS order_no
            FROM jadwal j
            LEFT OUTER JOIN dosen d ON j.DosenID = d.Login
            LEFT OUTER JOIN hari h ON j.HariID = h.HariID
            WHERE j.TahunID = '20131' AND j.NA = 'N' AND j.JenisJadwalID = 'K'
            UNION
            SELECT j.JadwalID, j.KodeID, j.TahunID, j.ProdiID, j.ProgramID, j.MKID, j.MKKode, j.Nama AS Nama_MK, j.HariID, h.Nama AS Hari, j.JamMulai, j.JamSelesai, j.RuangID,
            jd.DosenID, d.Nama AS Nama_Dosen, 0 AS order_no
            FROM jadwal j
            RIGHT OUTER JOIN jadwaldosen jd ON j.JadwalID = jd.JadwalID
            LEFT OUTER JOIN dosen d ON jd.DosenID = d.Login
            LEFT OUTER JOIN hari h ON j.HariID = h.HariID
            WHERE j.TahunID = '20131' AND j.NA = 'N' AND j.JenisJadwalID = 'K'
            ) a
            GROUP BY a.TahunID, a.MKKode, a.Nama_MK, a.HariID, a.JamMulai, a.JamSelesai, a.RuangID, a.DosenID
            ORDER BY a.TahunID, a.MKKode, a.Nama_MK, a.HariID, a.JamMulai, a.JamSelesai, a.RuangID, a.order_no, a.Nama_Dosen;

SELECT j.JadwalID, j.KodeID, j.TahunID, j.ProdiID, j.ProgramID, j.MKID, j.MKKode, j.Nama AS Nama_MK, j.HariID, h.Nama AS Hari, j.JamMulai, j.JamSelesai, j.RuangID,
            jd.DosenID, d.Nama AS Nama_Dosen, 2 AS order_no
            FROM jadwal j
            RIGHT OUTER JOIN jadwaldosen jd ON j.JadwalID = jd.JadwalID
            LEFT OUTER JOIN dosen d ON jd.DosenID = d.Login
            LEFT OUTER JOIN hari h ON j.HariID = h.HariID
            WHERE j.TahunID = '20131' AND j.NA = 'N';

SELECT j.JadwalID, j.KodeID, j.TahunID, j.ProdiID, j.ProgramID, j.MKID, j.MKKode, j.Nama AS Nama_MK, j.HariID, h.Nama AS Hari, j.JamMulai, j.JamSelesai, j.RuangID,
            j.DosenID, d.Nama AS Nama_Dosen, 1 AS order_no
            FROM jadwal j
            LEFT OUTER JOIN dosen d ON j.DosenID = d.Login
            LEFT OUTER JOIN hari h ON j.HariID = h.HariID
            WHERE j.TahunID = '20131' AND j.NA = 'N';