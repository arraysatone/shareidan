using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using ArraysAtOne_Final.Models;

namespace ArraysAtOne_Final.Controllers
{
    public class SENSOR_0001203BController : Controller
    {
        private CapstoneEntities db = new CapstoneEntities();

        // GET: SENSOR_0001203B
        public ActionResult Index()
        {
            return View(db.SENSOR_0001203B.ToList());
        }

        // GET: SENSOR_0001203B/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SENSOR_0001203B sENSOR_0001203B = db.SENSOR_0001203B.Find(id);
            if (sENSOR_0001203B == null)
            {
                return HttpNotFound();
            }
            return View(sENSOR_0001203B);
        }

        // GET: SENSOR_0001203B/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: SENSOR_0001203B/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,temp,movement")] SENSOR_0001203B sENSOR_0001203B)
        {
            if (ModelState.IsValid)
            {
                db.SENSOR_0001203B.Add(sENSOR_0001203B);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(sENSOR_0001203B);
        }

        // GET: SENSOR_0001203B/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SENSOR_0001203B sENSOR_0001203B = db.SENSOR_0001203B.Find(id);
            if (sENSOR_0001203B == null)
            {
                return HttpNotFound();
            }
            return View(sENSOR_0001203B);
        }

        // POST: SENSOR_0001203B/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,temp,movement,time")] SENSOR_0001203B sENSOR_0001203B)
        {
            if (ModelState.IsValid)
            {
                db.Entry(sENSOR_0001203B).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(sENSOR_0001203B);
        }

        // GET: SENSOR_0001203B/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SENSOR_0001203B sENSOR_0001203B = db.SENSOR_0001203B.Find(id);
            if (sENSOR_0001203B == null)
            {
                return HttpNotFound();
            }
            return View(sENSOR_0001203B);
        }

        // POST: SENSOR_0001203B/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            SENSOR_0001203B sENSOR_0001203B = db.SENSOR_0001203B.Find(id);
            db.SENSOR_0001203B.Remove(sENSOR_0001203B);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
