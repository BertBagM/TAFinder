$(document).ready(function() {
    if (courses instanceof Array) {
        var $coursesContainer = $('#courses-container');
        var $preferredSubjectCheckboxes = $('.preferred-subject-checkbox');

        updateCoursesList($coursesContainer, $preferredSubjectCheckboxes, courses);

        $preferredSubjectCheckboxes.on('change', function() {
            updateCoursesList($coursesContainer, $preferredSubjectCheckboxes, courses);
        });
    }
});


function updateCoursesList($el, $preferredSubjectCheckboxes, courses) {
    var filters = $preferredSubjectCheckboxes.filter(isChecked).map(getCheckboxValue);
    var filteredCourses = filters.length > 0 ? filterCourses(courses, filters) : courses;
    var html = renderCourses(filteredCourses);

    $el.html(html);
}

function renderCourses(courses) {
    html = "";
    $.each(courses, function(i, course) {
        html += `
            <div class="row">
                <div class="col-xs-12">
                    <label class="checkbox-inline">
                        <input type="checkbox" name="application[course_ids][]" value="${course.id}" />
                        <span>${course.subject} ${course.number}</span>
                    </label>
                </div>
            </div>
        `;
    });

    return html;
}

function filterCourses(courses, filters) {
    return courses.filter(function(course) {
        return $.inArray(course.subject, filters) != -1;
    });
}

function isChecked() {
    return this.checked;
}

function getCheckboxValue() {
    return this.value;
}