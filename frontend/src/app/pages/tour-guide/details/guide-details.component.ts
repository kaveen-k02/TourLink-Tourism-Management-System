import { Component, OnInit } from "@angular/core";
import { ActivatedRoute } from "@angular/router";
import { DriverGuideRatingDto } from "app/dto/driver-guide-rating-dto";
import { User } from "app/model/user";
import { DriverGuideRatingService } from "app/service/driver-guide-rating.service";
import { UserService } from "app/service/user.service";
import * as XLSX from 'xlsx';
import { saveAs } from 'file-saver';
import { MatSnackBar } from '@angular/material/snack-bar';
import { MatDialog } from '@angular/material/dialog';

@Component({
    selector: 'guide-details-cmp',
    moduleId: module.id,
    templateUrl: 'guide-details.component.html'
})

export class GuideDetailsComponent implements OnInit{

    user: User = new User();
    id: string
    reviews: DriverGuideRatingDto[];
    uname: string;

    constructor(private userService: UserService, private router: ActivatedRoute, private service: DriverGuideRatingService,
        private snackBar: MatSnackBar
    ) {}

    ngOnInit(): void {
        this.id = this.router.snapshot.params['id'];
        this.userService.getGuideById(this.id).subscribe(data =>{
            this.user = data;
            console.log(this.user)
        })

        this.uname = this.user.firstName;

        this.feedbaack();
    }

    feedbaack() {
        this.service.getAllDriverGuideRatingById(this.id).subscribe(data => {
            this.reviews = data;
            console.log(this.reviews)
        })
    }

    exportToExcel(): void {
        const boldStyle = { bold: true }; 
        const date = new Date().toLocaleDateString('en-US', {year: 'numeric', month: '2-digit', day: '2-digit'}).replace(/\//g, '-');
        const fileName = `${this.uname}_feedback_${date}.xlsx`;
      
        const data = this.reviews.map(review => ({
          Name: review.userName,
          Rating: review.rating,
          Comment: review.comment
        }));
      
        const worksheet: XLSX.WorkSheet = XLSX.utils.json_to_sheet(data);
        const workbook: XLSX.WorkBook = { Sheets: { 'data': worksheet }, SheetNames: ['data'] };
        const excelBuffer: any = XLSX.write(workbook, { bookType: 'xlsx', type: 'array' });
      
        const blob = new Blob([excelBuffer], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
        saveAs(blob, fileName);
      }
      
    
      downloadExcel(): void {
        this.feedbaack(); 
        setTimeout(() => {
          this.snackBar.open('Document generation has successfully complete.', 'Close', {
            duration: 2000,
          });
          this.exportToExcel();
        }, 1000); 
      }

}