<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<main class="main">
	<!-- Area map 위치 텍스트 -->
	<div class="area-map active mr-4px">
		<a href="#">
			<img src="/resources/images/home-map.svg" class="icon14">
			<span>Home</span>
		</a>
		<a href="#">
			<img src="/resources/images/arrow-right-gray.svg" class="icon14">
			<span>user Management</span>
		</a>
	</div>
	<!-- 대시보드 타이틀 -->
	<div class="second-title">
		user requests
	</div>

	<div class="second-tap-menu mt-12px">
		<button type="button" class="second-tap-btn active">All</button>
		<button type="button" class="second-tap-btn">Health alrets</button>
		<button type="button" class="second-tap-btn">Service request</button>
		<button type="button" class="second-tap-btn">Input checkup data</button>
		<button type="button" class="second-tap-btn">Checkup results</button>
	</div>

	<!-- 주요 콘텐츠 시작 -->
	<div class="second-container mt-18px">
		<div class="content-row">
			<!-- 좌측 입력폼 그룹 -->
			<div class="row-md-100">
				<div class="row-wrap">
					<div class="input-label01">
						User Name
					</div>
					<div class="row-input">
						<input type="text" class="input-txt02 hold" placeholder="Please enter"
							   oninput="limitLength(this, 30);">
					</div>
				</div>
				<div class="row-wrap">
					<div class="input-label01">
						Loing ID
					</div>
					<div class="row-input">
						<input type="text" class="input-txt02 hold" placeholder="Please enter"
							   oninput="limitLength(this, 30);">
					</div>
				</div>
			</div>

			<div class="row-md-100">
				<div class="row-wrap">
					<div class="input-label01">
						Phone
					</div>
					<div class="row-input">
						<input type="text" class="input-txt02" placeholder="Please enter"
							   oninput="limitLength(this, 30);">
					</div>
				</div>
				<div class="row-wrap">
					<div class="input-label01">
						UID
					</div>
					<div class="row-input">
						<input type="text" class="input-txt02 hold" placeholder="Please enter"
							   oninput="limitLength(this, 30);">
					</div>
				</div>
			</div>

			<div class="row-md-100">
				<div class="row-wrap">
					<div class="input-label01">
						Sex
					</div>
					<div class="dropdown">
						<button class="dropdown-search">Man<span><img class="icon20" alt=""
																	  src="/resources/images/arrow-gray-bottom.svg"></span></button>
						<div class="dropdown-content">
							<a href="#">Female</a>
							<a href="#">Man</a>
						</div>
					</div>
				</div>
				<div class="row-wrap">
					<div class="input-label01">
						In charge
					</div>
					<div class="dropdown">
						<button class="dropdown-search">Select <span><img class="icon20" alt=""
																		  src="/resources/images/arrow-gray-bottom.svg"></span></button>
						<div class="dropdown-content">
							<a href="#">In charge Name</a>
							<a href="#"></a>
							<a href="#"></a>
						</div>
					</div>
				</div>
			</div>

			<div class="row-md-100">
				<div class="row-wrap">
					<div class="input-label01">
						Date of birth
					</div>
					<div class="row-input">
						<input type="text" class="input-txt02" placeholder="Please enter"
							   oninput="limitLength(this, 30);">
					</div>
				</div>
				<div class="row-wrap">
					<div class="input-label01">
						Group
					</div>
					<div class="dropdown">
						<button class="dropdown-search">Select<span><img class="icon20" alt=""
																		 src="/resources/images/arrow-gray-bottom.svg"></span></button>
						<div class="dropdown-content">
							<a href="#">Group Name</a>
							<a href="#"></a>
							<a href="#"></a>
						</div>
					</div>
				</div>
			</div>

			<div class="row-md-100">
				<div class="row-wrap">
					<div class="input-label01">
						Height(cm)
					</div>
					<div class="row-input">
						<input type="text" class="input-txt02" placeholder="Please enter"
							   oninput="limitLength(this, 30);">
					</div>
				</div>
				<div class="row-wrap">
					<div class="input-label01 hold">
						Registration
						date
					</div>
					<div class="row-input">
						<input type="text" class="input-txt02" placeholder="Please enter"
							   oninput="limitLength(this, 30);">
					</div>
				</div>
			</div>

			<div class="row-md-100">
				<div class="row-wrap">
					<div class="input-label01">
						Weight(kg)
					</div>
					<div class="row-input">
						<input type="text" class="input-txt02" placeholder="Please enter"
							   oninput="limitLength(this, 30);">
					</div>
				</div>
				<div class="row-wrap">
					<div class="input-label01">
						Last access
					</div>
					<div class="row-input">
						<input type="text" class="input-txt02 hold" placeholder="Please enter"
							   oninput="limitLength(this, 30);">
					</div>
				</div>
			</div>

			<div class="row-md-100">
				<div class="row-wrap">
					<div class="input-label01">
						Address
					</div>
					<div class="row-input">
						<input type="text" class="input-txt02" placeholder="Please enter"
							   oninput="limitLength(this, 30);">
					</div>
				</div>
				<div class="row-wrap">
					<div class="input-label01">
						Account deletion
						request date
					</div>
					<div class="row-input">
						<input type="text" class="input-txt02 hold" placeholder="Please enter"
							   oninput="limitLength(this, 30);">
					</div>
				</div>
			</div>

			<div class="row-md-100">
				<div class="row-wrap">
					<div class="input-label01">
						Account status
					</div>
					<div class="dropdown">
						<button class="dropdown-search">Active <span><img class="icon20" alt=""
																		  src="/resources/images/arrow-gray-bottom.svg"></span></button>
						<div class="dropdown-content">
							<a href="#">Active</a>
							<a href="#">Suspended</a>
							<a href="#">Ready to delete</a>
						</div>
					</div>
				</div>
				<div class="row-wrap">
					<div class="input-label01">
						Pending deletion
					</div>
					<div class="row-input">
						<input type="text" class="input-txt02 hold mr-4px" placeholder="Please enter"
							   oninput="limitLength(this, 30);">
					</div>
					<div class="row-input">
						<input type="text" class="input-txt04 hold mx-w250" placeholder="Please enter"
							   oninput="limitLength(this, 30);">
					</div>
				</div>
			</div>

			<div class="row-col-100 mb-16px">
				<div class="input-label01 mb-4px">
					Memo
				</div>
				<div class="wrap-form">
                                    <textarea class="input-area" id="myTextarea"
											  placeholder="Please enter a note."></textarea>
				</div>
			</div>

			<div class="row-md-100">
				<div class="row-wrap">
					<div class="input-label01">
						Last edited
					</div>
					<div class="dropdown">
						<button class="dropdown-search">Active <span><img class="icon20" alt=""
																		  src="/resources/images/arrow-gray-bottom.svg"></span></button>
						<div class="dropdown-content">
							<a href="#">Active</a>
							<a href="#">Suspended</a>
							<a href="#">Ready to delete</a>
						</div>
					</div>
				</div>
				<div class="row-wrap">
					<div class="input-label01">
						Edited by
					</div>
					<div class="row-input">
						<input type="text" class="input-txt02" placeholder="Please enter"
							   oninput="limitLength(this, 30);">
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="content-submit-ui mt-22px">
		<div class="submit-ui-wrap">
			<button type="button" class="gray-submit-btn">
				<img src="/resources/images/reset-pass-icon.svg" class="icon22">
				<span>Reset Password</span>
			</button>
		</div>
		<div class="submit-ui-wrap">
			<button type="button" class="gray-submit-btn">
				<img src="/resources/images/reset-icon.svg" class="icon22">
				<span>Reset</span>
			</button>

			<button type="button" class="point-submit-btn">
				<img src="/resources/images/search-icon.svg" class="icon22">
				<span>Save Changes</span>
			</button>
		</div>
	</div>
	<div class="space-30"></div>
</main>
