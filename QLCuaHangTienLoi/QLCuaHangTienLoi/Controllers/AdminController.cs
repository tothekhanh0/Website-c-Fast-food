using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using QLCuaHangTienLoi.Models;
using PagedList;
using PagedList.Mvc;
using System.IO;

namespace QLCuaHangTienLoi.Controllers
{
    public class AdminController : Controller
    {
        dbQLCuaHangTienLoiDataContext db = new dbQLCuaHangTienLoiDataContext();
        // GET: Admin
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult SanPham(int ?page)
        {
            int pageNumber = (page ?? 1);
            int pageSize = 5;
            return View(db.sanPhams.ToList().OrderBy(n => n.maSP).ToPagedList(pageNumber, pageSize));
        }

        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(FormCollection collection)
        {
            //gan cac gia tri nguoi dung nhap lieu cho cac bien
            var tendn = collection["username"];
            var matkhau = collection["password"];
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
                // gan gia tri cho doi tuong duoc tao moi(ad)
                taiKhoanTV ad = db.taiKhoanTVs.SingleOrDefault(n => n.taiKhoan == tendn && n.matKhau == matkhau && n.maNhom == 1);
                if (ad != null)
                {
                    Session["Taikhoanadmin"] = ad;
                    return RedirectToAction("Index", "Admin");
                }
                else
                    ViewBag.Thongbao = "Tên đăng nhập hoặc mật khẩu không đúng";
            }
            return View();
        }

        [HttpGet]
        public ActionResult ThemmoiSP()
        {
            //đưa dữ liệu vào dropdownlist
            //lấy ds tu table, sắp xếp tăng dần, lấy giá trị và hiển thị
            ViewBag.maLoai = new SelectList(db.loaiSanPhams.ToList().OrderBy(n => n.loaiSP), "maLoai", "LoaiSP");           
            return View();
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult ThemmoiSP(sanPham sanpham, HttpPostedFileBase fileUpload)
        {
            // đưa dữ liệu vào dropdownload
            ViewBag.maLoai = new SelectList(db.loaiSanPhams.ToList().OrderBy(n => n.loaiSP), "maLoai", "LoaiSP");
            //kiem tra đường dẫn file
            if (fileUpload == null)
            {
                ViewBag.Thongbao = "Vui lòng chọn ảnh đại diện";
                return View();
            }
            //thêm vào csdl
            else
            {
                if (ModelState.IsValid)
                {
                    //luu tên file
                    var fileName = Path.GetFileName(fileUpload.FileName);
                    //lưu đường dẫn
                    var path = Path.Combine(Server.MapPath("~/images"), fileName);
                    //kiểm tra hình ảnh tồn tại chưa
                    if (System.IO.File.Exists(path))
                    {
                        ViewBag.ThongBao = "Hình ảnh đã tồn tại";
                    }
                    else
                    {
                        //lưu hình ảnh
                        fileUpload.SaveAs(path);
                    }
                    sanpham.hinhDD = fileName;
                    //luu vao csdl
                    db.sanPhams.InsertOnSubmit(sanpham);
                    db.SubmitChanges();
                    
                }
                return RedirectToAction("SanPham");
            }      
        }
        // hiển thị sản phẩm
        public ActionResult ChitietSP(string id)
        {
            //lấy đôi tượng theo mã
            sanPham sanpham = db.sanPhams.SingleOrDefault(n => n.maSP == id);
            ViewBag.maSP = sanpham.maSP;
            if(sanpham == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(sanpham);
        }
        // xóa sản phẩm
        [HttpGet]
        public ActionResult XoaSP(string id)
        {
            //lay ra doi tuong can xoa theo maSP
            sanPham sanpham = db.sanPhams.SingleOrDefault(n => n.maSP == id);
            ViewBag.maSP = sanpham.maSP;
            if(sanpham == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(sanpham);
        }
        [HttpPost, ActionName("XoaSP")]
        public ActionResult XacNhanXoa(string id)
        {
            // lay doi tuong can xoa theo ma
            sanPham sanpham = db.sanPhams.SingleOrDefault(n => n.maSP == id);
            ViewBag.maSP = sanpham.maSP;
            if(sanpham == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            db.sanPhams.DeleteOnSubmit(sanpham);
            db.SubmitChanges();
            return RedirectToAction("SanPham");
        }
        // chinh sua san pham
        [HttpGet]
        public ActionResult SuaSP(string id)
        {
            sanPham sanpham = db.sanPhams.SingleOrDefault(n => n.maSP == id);
            if(sanpham == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            ViewBag.maLoai = new SelectList(db.loaiSanPhams.ToList().OrderBy(n => n.maLoai), "maLoai", "LoaiSP", sanpham.maLoai);
            return View(sanpham);
        }
      
        //
        //view khach hang
        public ActionResult KhachHang()
        {
            return View(db.khachHangs.ToList());
        }
        // xóa KH
        [HttpGet]
        public ActionResult XoaKH(string id)
        {
            //lay ra doi tuong can xoa theo maSP
            khachHang kh = db.khachHangs.SingleOrDefault(n => n.maKH == id);
            ViewBag.maKH = kh.maKH;
            if (kh == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(kh);
        }
        [HttpPost, ActionName("XoaKH")]
        public ActionResult XacNhanXoaKH(string id)
        {
            // lay doi tuong can xoa theo ma
            khachHang kh = db.khachHangs.SingleOrDefault(n => n.maKH == id);
            ViewBag.maKH = kh.maKH;
            if (kh == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            db.khachHangs.DeleteOnSubmit(kh);
            db.SubmitChanges();
            return RedirectToAction("KhachHang");
        }
        // chinh sua khach hang
        [HttpGet]
        public ActionResult SuaKH(string id)
        {
            khachHang kh = db.khachHangs.SingleOrDefault(n => n.maKH == id);
            if (kh == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            
            return View(kh);
        }

        //view đơn hàng
        public ActionResult DonHang()
        {
            return View(db.donHangs.ToList());
        }
        //xoa dh
        [HttpGet]
        public ActionResult XoaDH(string id)
        {
            //lay ra doi tuong can xoa theo maSP
            donHang dh = db.donHangs.SingleOrDefault(n => n.soDH == id);
            ViewBag.soDH = dh.soDH;
            if (dh == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(dh);
        }
        [HttpPost, ActionName("XoaDH")]
        public ActionResult XacNhanXoaDH(string id)
        {
            // lay doi tuong can xoa theo ma
            donHang dh = db.donHangs.SingleOrDefault(n => n.soDH == id);
            ViewBag.soDH = dh.soDH;
            if (dh == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            db.donHangs.DeleteOnSubmit(dh);
            db.SubmitChanges();
            return RedirectToAction("DonHang");
        }
        // chinh sua dh
        [HttpGet]
        public ActionResult SuaDH(string id)
        {
            donHang dh = db.donHangs.SingleOrDefault(n => n.soDH == id);
            if (dh == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            
            return View(dh);
        }
        

        // view tài khoản thành viên
        public ActionResult TaiKhoanTV()
        {
            return View(db.taiKhoanTVs.ToList());
        }
        [HttpGet]
        public ActionResult ThemmoiTK()
        {
            //đưa dữ liệu vào dropdownlist
            //lấy ds tu table, sắp xếp tăng dần, lấy giá trị và hiển thị
            ViewBag.maQH = new SelectList(db.quanHuyens.ToList().OrderBy(n => n.tenQH), "maQH", "tenQH");
            return View();
        }
        // them moi tai khoan
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult ThemmoiTK(taiKhoanTV tk)
        {
            // đưa dữ liệu vào dropdownload
            ViewBag.maQH = new SelectList(db.quanHuyens.ToList().OrderBy(n => n.tenQH), "maQH", "tenQH");
            db.taiKhoanTVs.InsertOnSubmit(tk);
            db.SubmitChanges();
            return RedirectToAction("TaiKhoanTV");
        }
        //xoa tk
        [HttpGet]
        public ActionResult XoaTK(string id)
        {
            //lay ra doi tuong can xoa theo maSP
            taiKhoanTV tk = db.taiKhoanTVs.SingleOrDefault(n => n.taiKhoan == id);
            ViewBag.taiKhoan = tk.taiKhoan;
            if (tk == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(tk);
        }
        [HttpPost, ActionName("XoaTK")]
        public ActionResult XacNhanXoaTK(string id)
        {
            // lay doi tuong can xoa theo ma
            taiKhoanTV tk = db.taiKhoanTVs.SingleOrDefault(n => n.taiKhoan == id);
            ViewBag.taiKhoan = tk.taiKhoan;
            if (tk == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            db.taiKhoanTVs.DeleteOnSubmit(tk);
            db.SubmitChanges();
            return RedirectToAction("TaiKhoanTV");
        }
        // chinh sua tk
        [HttpGet]
        public ActionResult SuaTK(string id)
        {
            taiKhoanTV tk = db.taiKhoanTVs.SingleOrDefault(n => n.taiKhoan == id);
            if (tk == null)
            {
                Response.StatusCode = 404;
                return null;
            }

            return View(tk);
        }
       
    }
}