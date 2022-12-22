using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QLCuaHangTienLoi.Models
{
    public class GioHang
    {
        dbQLCuaHangTienLoiDataContext data = new dbQLCuaHangTienLoiDataContext();
        public string smaSP { set; get; }
        public string stenSP { set; get; }
        public string shinhDD { set; get; }
        public int igiaBan { set; get; }
        public int isoLuong { set; get; }
        public double dThanhtien
        {
            get { return isoLuong * igiaBan; }
        }
        public GioHang(string maSP)
        {
            smaSP = maSP;
            sanPham sanpham = data.sanPhams.Single(n => n.maSP == smaSP);
            stenSP = sanpham.tenSP;
            shinhDD = sanpham.hinhDD;
            igiaBan = int.Parse(sanpham.giaBan.ToString());
            isoLuong = 1;
        }
    }
}