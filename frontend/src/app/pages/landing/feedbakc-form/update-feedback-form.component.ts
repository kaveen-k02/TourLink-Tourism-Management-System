import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import { DriverGuideRatingDto } from 'app/dto/driver-guide-rating-dto';
import { AuthService } from 'app/service/auth.service';
import { DriverGuideRatingService } from 'app/service/driver-guide-rating.service';
import { error } from 'console';


@Component({
  selector: 'update-feedback-form-cmp',
  templateUrl: 'feedback-form.component.html'
})
export class UpdateFeedbackFormComponent implements OnInit {
    @Output() closeModal: EventEmitter<void> = new EventEmitter<void>();
    @Input() id: string;
    @Input() ty: string;
    rating: DriverGuideRatingDto = new DriverGuideRatingDto();
    sessionUserId: string;

  constructor(private snackBar: MatSnackBar, private authService: AuthService,
    private rateService: DriverGuideRatingService
  ) { }

  ngOnInit(): void {
    this.sessionUserId = this.authService.getUserAccountId();

    this.rateService.getSingleRating(this.id).subscribe(data => {
      this.rating = data;
    })
    console.log(this.id);

  }

  saveRate(){
    this.rateService.createRate(this.rating).subscribe(data => {
        console.log(data);
    },error => console.log(error))
  }

  submitForm() {
    this.rating.touristID = this.sessionUserId;
    this.rating.ratingId = this.id;
    this.rating.userName = this.ty;
    this.rating.edit = true;

    this.closeModal.emit();
    this.saveRate();
    this.snackBar.open('Feedback Update!', 'Fechar', {
        duration: 2000,
      });
  }

  closePopup() {
    this.closeModal.emit();
  }

  stopPropagation(event: Event) {
    event.stopPropagation();
  }
  
}