using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using QLCuaHangTienLoi.Models;

namespace QLCuaHangTienLoi.Controllers
{
    public class NguoiDungController : Controller
    {
        dbQLCuaHangTienLoiDataContext db = new dbQLCuaHangTienLoiDataContext();
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public ActionResult Dangky()
        {
            return View();
        }
        // post: ham dangky(post) nhan du lieu tu trang dang ky va thuc hien viec tao moi du lieu
        [HttpPost]
        public ActionResult Dangky(FormCollection collection, taiKhoanTV tk)
 
        {
            // gán giá trị người dùng nhập liệu cho các biến
            var TaiKhoan = collection["TenDN"];
            var MatKhau = collection["MatKhau"];
            var MatKhauNhapLai = collection["MatKhauNhapLai"];
            var HoDem = collection["HoDem"];
            var Ten = collection["Ten"];
            var DiaChi = collection["DiaChi"];
            var Email = collection["Email"];
            var DienThoai = collection["DienThoai"];
            var NgaySinh = string.Format("{0:MM/dd/yyyy}", collection["NgaySinh"]);
            if (string.IsNullOrEmpty(HoDem))
            {
                ViewData["Loi1"] = "Họ đệm không được để trống";
            }
            else if (string.IsNullOrEmpty(Ten))
            {
                ViewData["Loi2"] = "Tên không được để trống";
            }
            else if (string.IsNullOrEmpty(TaiKhoan))
            {
                ViewData["Loi3"] = "Phải nhập tên đang nhập";
            }
            else if (string.IsNullOrEmpty(MatKhau))
            {
                ViewData["Loi4"] = "Phải nhập mật khẩu";
            }
            else if (string.IsNullOrEmpty(MatKhauNhapLai))
            {
                ViewData["Loi5"] = "Phải nhập lại mật khẩu";
            }
            if (string.IsNullOrEmpty(Email))
            {
                ViewData["Loi6"] = "Email không được bỏ trống";
            }
            if (string.IsNullOrEmpty(DienThoai))
            {
                ViewData["Loi7"] = "Phải nhập số điện thoại";
            }
            if (string.IsNullOrEmpty(DiaChi))
            {
                ViewData["Loi8"] = "Phải nhập địa chỉ";
            }
            else
            {
                //gán giá trị cho đối tượng được tạo mới (kh)
                tk.hoDem = HoDem;
                tk.tenTV = Ten;
                tk.taiKhoan = TaiKhoan;
                tk.matKhau = MatKhau;
                tk.email = Email;
                tk.diaChi = DiaChi;
                tk.soDT = DienThoai;
                tk.ngaysinh = DateTime.Parse(NgaySinh);
                db.taiKhoanTVs.InsertOnSubmit(tk);
                db.SubmitChanges();
                return RedirectToAction("Dangnhap");
            }
            return this.Dangky();
        }
        [HttpGet]
        public ActionResult DangNhap()
        {
            return View();
        }
        [HttpPost]
        public ActionResult DangNhap(FormCollection collection)
        {
            var tendn = collection["TenDN"];
            var matkhau = collection["MatKhau"];
            if (string.IsNullOrEmpty(tendn))
            {
                ViewData["Loi1"] = "Phải nhập tên đăng nhập";
            }
            else if (string.IsNullOrEmpty(matkhau))
            {
                ViewData["Loi2"] = "Phải nhập mật khẩu";
            }
            else
            {
                taiKhoanTV tk = db.taiKhoanTVs.SingleOrDefault(n => n.taiKhoan == tendn && n.matKhau == matkhau);
                if (tk != null)
                {
                    //ViewBag.Thongbao = "Chúc mừng đăng nhập thành công";
                    Session["taiKhoan"] = tk;
                    return RedirectToAction("DatHang", "GioHang");
                }
                else
                    ViewBag.Thongbao = "Tên đăng nhập hoặc mật khẩu không đúng";
            }
            return View();
        }
    }
}