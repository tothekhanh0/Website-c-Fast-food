using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using QLCuaHangTienLoi.Models;

namespace QLCuaHangTienLoi.Controllers
{
    public class GioHangController : Controller
    {
        // tao doi tuong data chua du lieu tu model da tao
        dbQLCuaHangTienLoiDataContext data = new dbQLCuaHangTienLoiDataContext();

        public List<GioHang> LayGioHang()
        {
            List<GioHang> lstGioHang = Session["GioHang"] as List<GioHang>;
            if(lstGioHang==null)
            {
                lstGioHang = new List<GioHang>();
                Session["GioHang"] = lstGioHang;
            }
            return lstGioHang;
        }
        // them hang vao gio
        public ActionResult ThemGioHang(string smaSP, string strURL)
        {
            //lay ra session gio hang
            List<GioHang> lstGioHang = LayGioHang();
            //Kiem tra hang trong session
            GioHang sanpham = lstGioHang.Find(n => n.smaSP == smaSP);
            if(sanpham == null)
            {
                sanpham = new GioHang(smaSP);
                lstGioHang.Add(sanpham);
                return Redirect(strURL);
            }
            else
            {
                sanpham.isoLuong++;
                return Redirect(strURL);
            }         
        }
        //tong so luong
        private int TongSoLuong()
        {
            int iTongSoLuong = 0;
            List<GioHang> lstGioHang = Session["GioHang"] as List<GioHang>;
            if(lstGioHang != null)
            {
                iTongSoLuong = lstGioHang.Sum(n => n.isoLuong);
            }
            return iTongSoLuong;
        }
        //tinh tong tien
        private double TongTien()
        {
            double iTongTien = 0;
            List<GioHang> lstGioHang = Session["GioHang"] as List<GioHang>;
            if(lstGioHang != null)
            {
                iTongTien = lstGioHang.Sum(n => n.dThanhtien);
            }
            return iTongTien;
        }
        //xay dung trang gio hang
        public ActionResult GioHang()
        {
            List<GioHang> lstGioHang = LayGioHang();
            if(lstGioHang.Count == 0)
            {
                return RedirectToAction("BanHang", "BanHang");
            }
            ViewBag.TongSoLuong = TongSoLuong();
            ViewBag.TongTien = TongTien();
            return View(lstGioHang);
        }
        //tao partial view de hien thi thong tin gio hang
        public ActionResult GioHangPartial()
        {
            ViewBag.TongSoLuong = TongSoLuong();
            ViewBag.TongTien = TongTien();
            return PartialView();
        }
        // xoa gio hang
        public ActionResult XoaGioHang(string smaSP)
        {
            //lay gio hang tu session
            List<GioHang> lstGioHang = LayGioHang();
            //kiem tra
            GioHang sanpham = lstGioHang.SingleOrDefault(n => n.smaSP == smaSP);
            //neu ton tai thi cho sua
            if(sanpham != null)
            {
                lstGioHang.RemoveAll(n => n.smaSP == smaSP);
                return RedirectToAction("GioHang");
            }
            if (lstGioHang.Count == 0)
            {
                return RedirectToAction("BanHang", "BanHang");
            }
            return RedirectToAction("GioHang");
        }
        // cap nhat gio hang
        public ActionResult CapNhatGioHang(string smaSP, FormCollection f)
        {
            // lay gio hang
            List<GioHang> lstGioHang = LayGioHang();
            //kiem tra
            GioHang sanpham = lstGioHang.SingleOrDefault(n => n.smaSP == smaSP);
            //neu ton tai thi cho sua
            if(sanpham != null)
            {
                sanpham.isoLuong = int.Parse(f["txtSoluong"].ToString());
            }
            return RedirectToAction("GioHang");
        }
        public ActionResult XoaTatCaGioHang()
        {
            List<GioHang> lstGioHang = LayGioHang();
            lstGioHang.Clear();
            return RedirectToAction("BanHang", "BanHang");
        }
        //hien thi view DatHang de cap nhat cac thong tin cho don hang
        [HttpGet]
        public ActionResult DatHang()
        {
            //kiem tra dang nhap
            if (Session["taiKhoan"] == null || Session["taiKhoan"].ToString()=="")
            {
                return RedirectToAction("DangNhap", "NguoiDung");
            }
            if(Session["GioHang"] == null)
            {
                return RedirectToAction("BanHang", "BanHang");
            }
            List<GioHang> lstGioHang = LayGioHang();
            ViewBag.TongSoLuong = TongSoLuong();
            ViewBag.TongTien = TongTien();
            return View(lstGioHang);
        }
        public ActionResult DatHang(FormCollection collection)
        {
            // them don hang
            donHang dh = new donHang();
            khachHang kh = (khachHang)Session["khachHang"];
            List<GioHang> gh = LayGioHang();
            dh.maKH = kh.maKH;
            dh.ngayDat = DateTime.Now;
            var ngaygiao = string.Format("{0:MM/dd/yyyy}", collection["Ngaygiao"]);
            dh.ngayGH = DateTime.Parse(ngaygiao);
            dh.ghiChu = null;
            dh.daKichHoat = false;
            data.donHangs.InsertOnSubmit(dh);
            data.SubmitChanges();
            // them chi tiet don hang
            foreach(var item in gh)
            {
                ctDonHang ctdh = new ctDonHang();
                ctdh.soDH = dh.soDH;
                ctdh.maSP = item.smaSP;
                ctdh.soLuong = item.isoLuong;
                ctdh.giaBan = item.igiaBan;
                data.ctDonHangs.InsertOnSubmit(ctdh);
            }
            data.SubmitChanges();
            Session["GioHang"] = null;
            return RedirectToAction("XacNhanDonHang", "GioHang");
        }
        public ActionResult XacNhanDonHang()
        {
            return View();
        }
    }
}