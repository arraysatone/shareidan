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
    public class SENSORsController : Controller
    {
        private CapstoneEntities db = new CapstoneEntities();

        // GET: SENSORs
        public ActionResult Index()
        {
            return View(db.SENSORS.ToList());
        }

        // GET: SENSORs/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SENSOR sENSOR = db.SENSORS.Find(id);
            if (sENSOR == null)
            {
                return HttpNotFound();
            }
            return View(sENSOR);
        }

        // GET: SENSORs/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: SENSORs/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,uid,threshold")] SENSOR sENSOR)
        {
            if (ModelState.IsValid)
            {
                db.SENSORS.Add(sENSOR);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(sENSOR);
        }

        // GET: SENSORs/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SENSOR sENSOR = db.SENSORS.Find(id);
            if (sENSOR == null)
            {
                return HttpNotFound();
            }
            return View(sENSOR);
        }

        // POST: SENSORs/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,uid,threshold")] SENSOR sENSOR)
        {
            if (ModelState.IsValid)
            {
                db.Entry(sENSOR).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(sENSOR);
        }

        // GET: SENSORs/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SENSOR sENSOR = db.SENSORS.Find(id);
            if (sENSOR == null)
            {
                return HttpNotFound();
            }
            return View(sENSOR);
        }

        // POST: SENSORs/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            SENSOR sENSOR = db.SENSORS.Find(id);
            db.SENSORS.Remove(sENSOR);
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
