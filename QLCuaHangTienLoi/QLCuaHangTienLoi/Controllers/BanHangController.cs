using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using QLCuaHangTienLoi.Models;

namespace QLCuaHangTienLoi.Controllers
{
    public class BanHangController : Controller
    {
        // tao 1 doi tuong chua toan bo csdl tu database
        dbQLCuaHangTienLoiDataContext data = new dbQLCuaHangTienLoiDataContext();

        private List<sanPham> LaySanPhamMoi(int count)
        {
            // sap xep giam dan theo ngay cap nhat, lay count dong dau
            return data.sanPhams.OrderByDescending(a => a.ngayDang).Take(count).ToList();
        }
        public ActionResult BanHang()
        {
            // lay 5 san pham moi
            var sanpham = LaySanPhamMoi(8);
            return View(sanpham);
        }
        //liên hệ
        public ActionResult LienHe()
        {
            return View();
        }
        //gioi thieu
        public ActionResult GioiThieu()
        {
            return View();
        }

        public ActionResult LoaiSP()
        {
            var loaiSP = from lsp in data.loaiSanPhams select lsp;
            return PartialView(loaiSP);
        }
        public ActionResult SPTheoDanhMuc(int id)
        {
            var sanpham = from sp in data.sanPhams where sp.maLoai == id select sp;
            return View(sanpham);
        }

        public ActionResult Details(string id)
        {
            var sanpham = from sp in data.sanPhams
                          where sp.maSP == id
                          select sp;
            return View(sanpham.Single());
        }
        public ActionResult Seach(string seachString)
        {
            if (string.IsNullOrEmpty(seachString))
                return RedirectToAction("BanHang", "BanHang");
            else
            {
                ViewData.Model = data.sanPhams.Where(n => n.tenSP == seachString).ToList();
            }
            return View();
        }
    }
}